import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_and_guess/src/app/game/data/models/game_model.dart';
import 'package:draw_and_guess/src/app/history/data/models/exhibit_model.dart';
import 'package:draw_and_guess/src/core/service/logger.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/util/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef CachedData<T> = ({T data, DateTime expiry});
final _exhibitsCache = <String, CachedData<List<ExhibitModel>>>{};

final class HistoryRepository {
  const HistoryRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  static const _logger = Logger('HistoryRepository');

  Future<Result<List<GameModel>>> getHistory({
    int pageSize = 10,
    GameModel? lastItem,
  }) async {
    try {
      _logger.request('Getting history - ${firebaseAuth.currentUser!.uid}');
      Query query = firebaseFirestore
          .collection('games')
          .orderBy('created_at', descending: true)
          .where('uids', arrayContains: firebaseAuth.currentUser!.uid)
          .limit(pageSize);

      if (lastItem != null) {
        _logger.info('After - ${lastItem.id}');
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

  Future<List<ExhibitModel>> getExhibits(String id) async {
    try {
      _logger.request('Getting exhibits - $id');
      if (_exhibitsCache[id] != null && _exhibitsCache[id]!.expiry.isNotExpired) {
        _logger.request('Exhibits available in cache');
        return Future.value(_exhibitsCache[id]!.data);
      }

      final exhibits = await firebaseFirestore
          .collection('games/$id/exhibits')
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
