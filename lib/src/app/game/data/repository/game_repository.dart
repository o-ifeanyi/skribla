import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/game/data/models/message_model.dart';
import 'package:skribla/src/app/game/data/models/player_model.dart';
import 'package:skribla/src/app/history/data/models/exhibit_model.dart';
import 'package:skribla/src/app/leaderboard/data/repository/leaderboard_repository.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/result.dart';

final class GameRepository {
  const GameRepository({
    required this.loc,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.leaderboardRepository,
  });

  final AppLocalizations loc;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final LeaderboardRepository leaderboardRepository;
  static const _logger = Logger('GameRepository');

  Future<Result<bool>> leaveGame({
    required String uid,
    required GameModel game,
  }) async {
    try {
      _logger.request('Leaving game - uid $uid, id ${game.id}');

      // only one player joined
      // or last online player is leaving when no art has been drawn
      // or it's been over an hour and no art has been drawn

      final existence = DateTime.now().difference(game.createdAt.toLocal());
      if (game.players.length == 1 ||
          (game.online.length == 1 && game.numOfArts == 0) ||
          (game.numOfArts == 0 && existence.inMinutes > 60)) {
        await firebaseFirestore.collection('games').doc(game.id).delete();
        _logger.info('Game deleted - uid $uid, id ${game.id}');
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
      return firebaseFirestore.collection('games').where('id', isEqualTo: id).snapshots().map(
            (event) => event.docs
                .map(
                  (e) => GameModel.fromJson(e.data()),
                )
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
      players[currentPlayerIndex] = players[currentPlayerIndex].copyWith(
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
        final doc = firebaseFirestore.collection('games/${game.id}/exhibits').doc();
        final exhibit = ExhibitModel(
          id: doc.id,
          player: game.currentPlayer,
          word: game.currentWord,
          art: game.currentArt,
          createdAt: DateTime.now(),
        );
        unawaited(doc.set(exhibit.toJson()));
        unawaited(
          firebaseFirestore.collection('games').doc(game.id).update(
            {'num_of_arts': FieldValue.increment(1)},
          ),
        );
        unawaited(
          sendMessage(
            game: game,
            text: loc.revealWordMsg(game.currentWord.text),
            name: null,
          ),
        );
      }

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('updateNextPlayer - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  Future<Result<bool>> sendMessage({
    required GameModel game,
    required String text,
    required String? name,
  }) async {
    try {
      _logger.request('Sending message - games/${game.id}/messages');

      final doc = firebaseFirestore.collection('games/${game.id}/messages').doc();
      final uid = firebaseAuth.currentUser!.uid;
      final correctGuess = game.currentWord.text.toLowerCase() == text.toLowerCase();
      final message = MessageModel(
        id: doc.id,
        uid: (correctGuess || name == null) ? 'game_bot' : uid,
        text: correctGuess ? loc.correctGuessMsg('$name') : text,
        name: (correctGuess || name == null) ? null : name,
        correctGuess: correctGuess,
        createdAt: DateTime.now(),
      );

      await doc.set(message.toJson());

      if (correctGuess && !game.correctGuess.contains(uid)) {
        // update guesser points by Constants.points
        final players = List<PlayerModel>.from(game.players);
        final guesserIndex = game.players.indexWhere(
          (player) => player.uid == uid,
        );
        players[guesserIndex] = players[guesserIndex].copyWith(
          points: players[guesserIndex].points + Constants.points,
        );
        // update current player points by Constants.points
        final currentPlayerIndex = game.players.indexWhere(
          (player) => player.uid == game.currentPlayer.uid,
        );
        players[currentPlayerIndex] = players[currentPlayerIndex].copyWith(
          points: players[currentPlayerIndex].points + Constants.points,
        );

        unawaited(
          firebaseFirestore.collection('games').doc(game.id).update({
            'players': players.map((e) => e.toJson()).toList(),
            'correct_guess': FieldValue.arrayUnion([uid]),
          }),
        );

        // update guesser and player points in leadear board
        unawaited(
          leaderboardRepository.updateLeaderboard(
            players: [players[currentPlayerIndex], players[guesserIndex]],
          ),
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
