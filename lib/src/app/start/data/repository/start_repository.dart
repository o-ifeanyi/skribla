import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/result.dart';

final class StartRepository {
  const StartRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  static const _logger = Logger('StartRepository');

  Future<Result<String>> findGame(UserModel user) async {
    try {
      _logger.request('Finding game - ${user.uid}');
      final ongoing = await firebaseFirestore
          .collection('games')
          .where('status', isEqualTo: Status.open.name)
          .get();

      // fetch player words first
      final words = Constants.words.take(2).toList();

      GameModel game;
      if (ongoing.size == 0) {
        _logger.info('Creating game');
        final player = user.toPlayer().copyWith(words: words);
        final doc = firebaseFirestore.collection('games').doc();
        game = GameModel(
          id: doc.id,
          currentPlayer: player,
          currentWord: words.first,
          players: [player],
          uids: [player.uid],
          online: [player.uid],
          createdAt: DateTime.now(),
        );
        await doc.set(game.toJson());
      } else {
        _logger.info('Joining game');
        game = GameModel.fromJson(ongoing.docs.first.data());
        final doc = firebaseFirestore.collection('games').doc(game.id);
        final player = game.players.firstWhere(
          (e) => e.uid == user.uid,
          orElse: () => user.toPlayer().copyWith(words: words),
        );

        await doc.update(
          {
            'players': FieldValue.arrayUnion([player.toJson()]),
            'uids': FieldValue.arrayUnion([player.uid]),
            'online': FieldValue.arrayUnion([player.uid]),
            if (game.online.length >= game.numOfPlayers - 1) ...{
              'status': Status.closed.name,
            },
          },
        );
      }

      return Result.success(game.id);
    } catch (e, s) {
      _logger.error('findGame - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }
}
