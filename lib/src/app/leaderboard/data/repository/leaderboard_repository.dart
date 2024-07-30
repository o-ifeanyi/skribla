import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_and_guess/src/app/leaderboard/data/models/leaderboard_model.dart';
import 'package:draw_and_guess/src/core/service/logger.dart';
import 'package:draw_and_guess/src/core/util/constants.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/util/result.dart';
import 'package:draw_and_guess/src/core/util/types.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LeaderboardType { monthly, alltime }

final _positionCache = <LeaderboardType, CachedData<LeaderboardPosition>>{};

final class LeaderboardRepository {
  const LeaderboardRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });
  static const _logger = Logger('LeaderboardRepository');

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  Future<Result<bool>> updateLeaderboard({
    required List<String> uids,
    int points = Constants.points,
  }) async {
    try {
      _logger.request('Updating leaderboard - $points - $uids');
      for (final type in LeaderboardType.values) {
        for (final uid in uids) {
          final doc = firebaseFirestore.collection('leaderboard/${type.name}/users').doc(uid);
          final now = DateTime.now();
          final data = await doc.get();
          if (data.exists) {
            await doc.update({'score': FieldValue.increment(points), 'updated_at': now});
            await doc.update({'score': FieldValue.increment(points), 'updated_at': now});
          } else {
            final model = LeaderboardModel(
              uid: uid,
              points: points,
              updatedAt: now,
              createdAt: now,
            );
            await doc.set(model.toJson());
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

  Future<Result<List<LeaderboardModel>>> getLeaderboard({
    required LeaderboardType type,
    int pageSize = 10,
    LeaderboardModel? lastItem,
  }) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      _logger.request('Getting leaderboard - leaderboard/${type.name}/users/$uid');
      Query query = firebaseFirestore
          .collection('leaderboard/${type.name}/users/$uid')
          .orderBy('points', descending: true)
          .limit(pageSize);

      if (lastItem != null) {
        _logger.info('After - ${lastItem.points}');
        query = query.startAfter([lastItem.points]);
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

  Future<LeaderboardPosition> getLeaderboardPosition(LeaderboardType type) async {
    try {
      if (_positionCache[type] != null && _positionCache[type]!.expiry.isNotExpired) {
        _logger.request('Position available in cache');
        return Future.value(_positionCache[type]!.data);
      }
      final uid = firebaseAuth.currentUser!.uid;
      _logger.request('Getting leaderboard position - leaderboard/${type.name}/users/$uid');
      final model = await firebaseFirestore
          .collection('leaderboard/${type.name}/users')
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
        final msg = 'Leaderboard position not available - ${type.name}';
        _logger.info(msg);
        throw CustomError(message: msg);
      }
      final positions = await firebaseFirestore
          .collection('leaderboard/${type.name}/$uid')
          .where('points', isGreaterThanOrEqualTo: model.points)
          .get();

      _positionCache[type] = (
        data: (position: positions.size + 1, model: model),
        expiry: DateTime.now().add(const Duration(minutes: 30)),
      );

      return (position: positions.size + 1, model: model);
    } catch (e, s) {
      _logger.error('getLeaderboardPosition - $e', stack: s);
      rethrow;
    }
  }
}
