import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_and_guess/src/app/game/data/models/exhibit_model.dart';
import 'package:draw_and_guess/src/app/game/data/models/game_model.dart';
import 'package:draw_and_guess/src/app/game/data/models/message_model.dart';
import 'package:draw_and_guess/src/app/game/data/models/player_model.dart';
import 'package:draw_and_guess/src/core/service/logger.dart';
import 'package:draw_and_guess/src/core/util/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

final class GameRepository {
  const GameRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  static const _logger = Logger('GameRepository');

  Future<Result<bool>> leaveGame({
    required String uid,
    required GameModel game,
  }) async {
    try {
      _logger.request('Leaving game - uid $uid, id ${game.id}');

      // only one player joined
      if (game.players.length == 1) {
        await firebaseFirestore.collection('games').doc(game.id).delete();
        return const Result.success(true);
      }

      await firebaseFirestore.collection('games').doc(game.id).update(
        {
          'online': FieldValue.arrayRemove([uid]),
          if (game.online.length == 1) ...{
            'status': Status.complete.name,
          },
        },
      );

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('leaveGame - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  Stream<GameModel?> getGameStream(String id) {
    try {
      _logger.request('Getting game stream game - $id');
      return firebaseFirestore
          .collection('games')
          .where('id', isEqualTo: id)
          .snapshots()
          .map(
            (event) => event.docs
                .map((e) => GameModel.fromJson(e.data()))
                .toList()
                .firstOrNull,
          );
    } catch (e, s) {
      _logger.error('getGameStream - $e', stack: s);
      return const Stream.empty();
    }
  }

  Future<Result<bool>> updateGameArt(GameModel game) async {
    try {
      _logger.request('Updating art - ${game.currentArt}');
      await firebaseFirestore.collection('games').doc(game.id).update(
        {'current_art': game.currentArt.map((e) => e.toJson()).toList()},
      );

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('updateGameArt - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  Future<Result<bool>> updateNextPlayer(GameModel game) async {
    try {
      _logger.request('Updating next player');
      if (game.online.length == 1) {
        const message = 'Only one player left';
        _logger.info(message);
        return const Result.error(CustomError(message: message));
      }

      // select the next player
      final currentPlayerOnlineIndex = game.online.indexOf(
        game.currentPlayer.uid,
      );
      final nextPlayerAndWord = game.nextPlayerAndWord(
        currentPlayerOnlineIndex,
      );

      // update current word to unavailable
      final currentPlayerIndex = game.players.indexWhere(
        (player) => player.uid == game.currentPlayer.uid,
      );
      final players = List<PlayerModel>.from(game.players);
      players[currentPlayerIndex] = game.currentPlayer.copyWith(
        words: game.currentPlayer.words.map((word) {
          if (word.id == game.currentWord.id) {
            return word.copyWith(available: false);
          }
          return word;
        }).toList(),
      );

      await firebaseFirestore.collection('games').doc(game.id).update(
        {
          'players': players.map((e) => e.toJson()).toList(),
          'current_player': nextPlayerAndWord.player.toJson(),
          'current_art': [],
          'correct_guess': [],
          if (nextPlayerAndWord.word != null) ...{
            'current_word': nextPlayerAndWord.word!.toJson(),
          } else ...{
            'status': Status.complete.name,
          },
        },
      );

      if (game.currentArt.isNotEmpty) {
        // add previous play to exhibits
        final doc =
            firebaseFirestore.collection('games/${game.id}/exhibits').doc();
        final exhibit = ExhibitModel(
          id: doc.id,
          player: game.currentPlayer,
          word: game.currentWord,
          art: game.currentArt,
          createdAt: DateTime.now(),
        );
        unawaited(doc.set(exhibit.toJson()));
        unawaited(
          sendMessage(
            game: game,
            text: 'the word was ${game.currentWord.text}'.toUpperCase(),
            name: null,
          ),
        );
      }

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('updateGameArt - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  Future<Result<bool>> sendMessage({
    required GameModel game,
    required String text,
    required String? name,
  }) async {
    try {
      final path = 'games/${game.id}/messages';
      _logger.request('Sending message - $path');

      final doc = firebaseFirestore.collection(path).doc();
      final uid = firebaseAuth.currentUser!.uid;
      final correctGuess =
          game.currentWord.text.toLowerCase() == text.toLowerCase();
      final message = MessageModel(
        id: doc.id,
        uid: (correctGuess || name == null) ? 'game_bot' : uid,
        text: correctGuess ? '$name guessed the word!' : text,
        name: (correctGuess || name == null) ? null : name,
        correctGuess: correctGuess,
        createdAt: DateTime.now(),
      );

      await doc.set(message.toJson());

      if (correctGuess) {
        unawaited(
          firebaseFirestore.collection('games').doc(game.id).update({
            'correct_guess': FieldValue.arrayUnion([uid]),
          }),
        );
      }

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('sendMessage - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  Stream<List<MessageModel>> getMessages(String id) {
    try {
      _logger.request('Getting messages - games/$id/messages');
      return firebaseFirestore
          .collection('games/$id/messages')
          .orderBy('created_at')
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => MessageModel.fromJson(e.data()),
                )
                .toList(),
          );
    } catch (e, s) {
      _logger.error('getMessages - $e', stack: s);
      return const Stream.empty();
    }
  }
}
