import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/history/data/models/exhibit_model.dart';
import 'package:skribla/src/core/resource/firebase_paths.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/util/result.dart';
import 'package:skribla/src/core/util/types.dart';

/// A cache to store exhibits data for each game, keyed by game ID.
/// The cache uses [CachedData] to store both the data and its expiry time.
final _exhibitsCache = <String, CachedData<List<ExhibitModel>>>{};

/// Repository class for managing history-related data operations.
///
/// It interacts with Firebase services (Authentication and Firestore) to
/// perform these operations.
///
/// Key methods:
/// - [getHistory]: Gets the game history.
/// - [getExhibits]: Gets the exhibits for a game.

final class HistoryRepository {
  const HistoryRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  static const _logger = Logger('HistoryRepository');

  /// Retrieves the game history for the current user.
  ///
  /// This method fetches a list of [GameModel] objects representing the user's game history.
  /// It supports pagination through the [pageSize] and [lastItem] parameters.
  ///
  /// Parameters:
  /// - [pageSize]: The number of items to fetch per page. Defaults to 10.
  /// - [lastItem]: The last [GameModel] from the previous page, used for pagination. Optional.
  ///
  /// Returns a [Result] containing a [List<GameModel>] on success, or a [CustomError] on failure.
  Future<Result<List<GameModel>>> getHistory({
    int pageSize = 10,
    GameModel? lastItem,
  }) async {
    try {
      _logger.request('Getting history - ${firebaseAuth.currentUser!.uid}');
      Query query = firebaseFirestore
          .collection(FirebasePaths.games)
          .orderBy('created_at', descending: true)
          .where('uids', arrayContains: firebaseAuth.currentUser!.uid)
          .limit(pageSize);

      if (lastItem != null) {
        _logger.info('After - ${lastItem.createdAt.toIso8601String()}');
        query = query.startAfter([lastItem.createdAt.toIso8601String()]);
      }
      final history = await query
          .withConverter(
            fromFirestore: (snapshot, _) => GameModel.fromJson(snapshot.data()!),
            toFirestore: (model, __) => model.toJson(),
          )
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      return Result.success(history);
    } catch (e, s) {
      _logger.error('getHistory - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  /// Fetches exhibits for a specific game.
  ///
  /// This method retrieves a list of [ExhibitModel] objects for the given game ID.
  /// It implements caching to improve performance and reduce database queries.
  ///
  /// Parameters:
  /// - [id]: The ID of the game for which to fetch exhibits.
  ///
  /// Returns a [Future<List<ExhibitModel>>] containing the exhibits for the specified game.
  /// If cached data is available and not expired, it returns the cached data instead of querying the database.
  ///
  /// Note: This method rethrows any caught errors, so the caller needs to handle potential exceptions.
  Future<List<ExhibitModel>> getExhibits(String id) async {
    try {
      _logger.request('Getting exhibits - $id');
      if (_exhibitsCache[id] != null && _exhibitsCache[id]!.expiry.isNotExpired) {
        _logger.request('Exhibits available in cache');
        return Future.value(_exhibitsCache[id]!.data);
      }

      final exhibits = await firebaseFirestore
          .collection(FirebasePaths.exhibits(id))
          .orderBy('created_at', descending: true)
          .withConverter(
            fromFirestore: (snapshot, _) => ExhibitModel.fromJson(snapshot.data()!),
            toFirestore: (model, __) => model.toJson(),
          )
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());

      _exhibitsCache[id] = (
        data: exhibits,
        expiry: DateTime.now().add(const Duration(minutes: 30)),
      );
      return exhibits;
    } catch (e, s) {
      _logger.error('getExhibits - $e', stack: s);
      rethrow;
    }
  }
}
