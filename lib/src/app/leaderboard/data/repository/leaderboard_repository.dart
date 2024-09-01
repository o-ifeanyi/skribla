import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skribla/src/app/game/data/models/player_model.dart';
import 'package:skribla/src/app/leaderboard/data/models/leaderboard_model.dart';
import 'package:skribla/src/core/resource/firebase_paths.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/enums.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/util/result.dart';
import 'package:skribla/src/core/util/types.dart';

final _positionCache = <LeaderboardType, CachedData<LeaderboardPosition>>{};

/// Repository class for managing leaderboard-related data operations.
///
/// It interacts with Firebase services (Authentication and Firestore) to
/// perform these operations.
///
/// Key methods:
/// - [updateLeaderboard]: Updates the leaderboard scores for a list of players.
/// - [getLeaderboard]: Gets the leaderboard.
/// - [getLeaderboardPosition]: Gets the leaderboard position.

final class LeaderboardRepository {
  const LeaderboardRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });
  static const _logger = Logger('LeaderboardRepository');

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  /// Updates the leaderboard scores for a list of players.
  ///
  /// This method updates both the monthly and all-time leaderboards for each player.
  /// If a player doesn't exist in the leaderboard, a new entry is created.
  ///
  /// Parameters:
  /// - [players]: A list of [PlayerModel] objects representing the players to update.
  /// - [points]: The number of points to add to each player's score. Defaults to [Constants.points].
  ///
  /// Returns a [Result] containing a boolean indicating success or failure.
  Future<Result<bool>> updateLeaderboard({
    required List<PlayerModel> players,
    int points = Constants.points,
  }) async {
    try {
      _logger.request('Updating leaderboard - $points');
      for (final type in LeaderboardType.values) {
        for (final player in players) {
          final doc = firebaseFirestore.collection(FirebasePaths.leaderboard(type)).doc(player.uid);
          final now = DateTime.now();
          final data = await doc.get();
          if (data.exists) {
            await doc.update({
              'points': FieldValue.increment(points),
              'name': player.name,
              'updated_at': now.toIso8601String(),
            });
          } else {
            final model = LeaderboardModel(
              uid: player.uid,
              name: player.name,
              points: points,
              updatedAt: now,
              createdAt: now,
            );
            await doc.set(model.toJson());
          }
        }
      }
      return const Result.success(true);
    } catch (e, s) {
      _logger.error('updateLeaderboard - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  /// Retrieves leaderboard data for a specific leaderboard type.
  ///
  /// This method fetches a paginated list of [LeaderboardModel] objects,
  /// sorted by points in descending order and then by update time.
  ///
  /// Parameters:
  /// - [type]: The [LeaderboardType] to fetch (monthly or all-time).
  /// - [pageSize]: The number of items to fetch per page. Defaults to 10.
  /// - [lastItem]: The last [LeaderboardModel] from the previous page, used for pagination. Optional.
  ///
  /// Returns a [Result] containing a [List<LeaderboardModel>] on success, or a [CustomError] on failure.
  Future<Result<List<LeaderboardModel>>> getLeaderboard({
    required LeaderboardType type,
    int pageSize = 10,
    LeaderboardModel? lastItem,
  }) async {
    try {
      _logger.request('Getting leaderboard - ${FirebasePaths.leaderboard(type)}');
      Query query = firebaseFirestore
          .collection(FirebasePaths.leaderboard(type))
          .orderBy('points', descending: true)
          .orderBy('updated_at', descending: false)
          .limit(pageSize);

      if (lastItem != null) {
        _logger.info('After - ${lastItem.points}, ${lastItem.updatedAt.toIso8601String()}');
        query = query.startAfter([lastItem.points, lastItem.updatedAt.toIso8601String()]);
      }
      final leaderboard = await query
          .withConverter(
            fromFirestore: (snapshot, _) => LeaderboardModel.fromJson(snapshot.data()!),
            toFirestore: (model, __) => model.toJson(),
          )
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());

      return Result.success(leaderboard);
    } catch (e, s) {
      _logger.error('getLeaderboard - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  /// Retrieves a user's position on the leaderboard.
  ///
  /// This method fetches the current user's position on either the monthly or all-time leaderboard.
  /// It implements caching to improve performance and reduce database queries.
  ///
  /// Parameters:
  /// - [type]: The [LeaderboardType] to check (monthly or all-time).
  ///
  /// Returns a [Future<LeaderboardPosition>] containing the user's position and total points.
  /// If cached data is available and not expired, it returns the cached data instead of querying the database.
  ///
  /// Note: This method rethrows any caught errors, so the caller needs to handle potential exceptions.
  Future<LeaderboardPosition> getLeaderboardPosition(LeaderboardType type) async {
    try {
      if (_positionCache[type] != null && _positionCache[type]!.expiry.isNotExpired) {
        _logger.request('Position available in cache');
        return Future.value(_positionCache[type]!.data);
      }
      final uid = firebaseAuth.currentUser!.uid;
      _logger.request('Getting leaderboard position - ${FirebasePaths.leaderboard(type)}/$uid');
      final model = await firebaseFirestore
          .collection(FirebasePaths.leaderboard(type))
          .doc(uid)
          .withConverter(
            fromFirestore: (snapshot, _) {
              if (!snapshot.exists) return null;
              return LeaderboardModel.fromJson(snapshot.data()!);
            },
            toFirestore: (model, __) => model?.toJson() ?? {},
          )
          .get()
          .then((value) => value.data());
      if (model == null) {
        const msg = 'Leaderboard position not available'; // localise this
        _logger.info(msg);
        throw const CustomError(message: msg, reason: ErrorReason.noPoints);
      }
      final positions = await firebaseFirestore
          .collection(FirebasePaths.leaderboard(type))
          .where('points', isGreaterThanOrEqualTo: model.points)
          .where('updated_at', isLessThanOrEqualTo: model.updatedAt.toIso8601String())
          .get();

      _positionCache[type] = (
        data: (position: positions.size, model: model),
        expiry: DateTime.now().add(const Duration(minutes: 30)),
      );

      return (position: positions.size, model: model);
    } catch (e, s) {
      _logger.error('getLeaderboardPosition - $e', stack: s);
      rethrow;
    }
  }
}
