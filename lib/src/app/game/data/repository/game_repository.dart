import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/game/data/models/message_model.dart';
import 'package:skribla/src/app/game/data/models/player_model.dart';
import 'package:skribla/src/app/game/data/models/report_model.dart';
import 'package:skribla/src/app/history/data/models/exhibit_model.dart';
import 'package:skribla/src/app/leaderboard/data/repository/leaderboard_repository.dart';
import 'package:skribla/src/core/resource/firebase_paths.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/enums.dart';
import 'package:skribla/src/core/util/result.dart';

/// Repository class for managing game-related data operations.
///
/// It interacts with Firebase services (Authentication and Firestore) to
/// perform these operations.
///
/// It also utilizes [LeaderboardRepository] to update leaderboard and [AppLocalizations]
/// to localize the error messages.
///
/// Key methods:
/// - [leaveGame]: Leaves a game.
/// - [getGameStream]: Gets a stream of a game.
/// - [updateGameArt]: Updates the art of a game.
/// - [updateNextPlayer]: Updates the next player of a game.
/// - [sendMessage]: Sends a message to a game.
/// - [getMessages]: Gets messages from a game.

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

  /// Leaves a game for the given user.
  ///
  /// This method updates the game document in Firestore to remove the user from the game.
  /// It checks specific conditions before allowing the user to leave the game, such as:
  /// - If the user is the only player in the game.
  /// - If the user is the last online player and no art has been drawn.
  /// - If it's been over an hour since the game started and no art has been drawn.
  ///
  /// If any of these conditions are met, the game is deleted. Otherwise, the user is removed from the game.
  ///
  /// Parameters:
  /// - [uid]: The ID of the user leaving the game.
  /// - [game]: The [GameModel] object representing the game.
  ///
  /// Returns a [Result] containing a boolean indicating success or failure.
  /// If successful, it returns `true`. If an error occurs, it returns an error object.
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
        await firebaseFirestore.collection(FirebasePaths.games).doc(game.id).delete();
        _logger.info('Game deleted - uid $uid, id ${game.id}');
        return const Result.success(true);
      }

      await firebaseFirestore.collection(FirebasePaths.games).doc(game.id).update(
        {
          'online': FieldValue.arrayRemove([uid]),
          if (game.online.length == 1) ...{
            'status': GameStatus.complete.name,
          },
        },
      );

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('leaveGame - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  /// Retrieves a stream of the game document with the specified ID.
  ///
  /// This method fetches a stream of the game document from Firestore based on the provided game ID.
  /// It maps the snapshot to a [GameModel] object and returns a stream of the game model.
  ///
  /// Parameters:
  /// - [id]: The ID of the game to fetch.
  ///
  /// Returns a [Stream] of [GameModel] containing the game data. If the game is not found, it returns null.
  Stream<GameModel?> getGameStream(String id) {
    try {
      _logger.request('Getting game stream game - $id');
      return firebaseFirestore
          .collection(FirebasePaths.games)
          .where('id', isEqualTo: id)
          .snapshots()
          .map(
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

  /// Updates the game art in Firestore.
  ///
  /// This method updates the game's current art in Firestore based on the provided game model.
  ///
  /// Parameters:
  /// - [game]: The [GameModel] containing the game data to update.
  ///
  /// Returns a [Future] containing a [Result] with a boolean value indicating the success of the operation or an error if the operation fails.
  Future<Result<bool>> updateGameArt(GameModel game) async {
    try {
      _logger.request('Updating art - ${game.currentArt}');
      await firebaseFirestore.collection(FirebasePaths.games).doc(game.id).update(
        {'current_art': game.currentArt.map((e) => e.toJson()).toList()},
      );

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('updateGameArt - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  /// Updates the next player in the game.
  ///
  /// This method updates the next player in the game based on the provided game model.
  ///
  /// Parameters:
  /// - [game]: The [GameModel] containing the game data to update.
  ///
  /// Returns a [Future] containing a [Result] with a boolean value indicating the success of the operation or an error if the operation fails.
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

      await firebaseFirestore.collection(FirebasePaths.games).doc(game.id).update(
        {
          'players': players.map((e) => e.toJson()).toList(),
          'current_player': nextPlayerAndWord.player.toJson(),
          'current_art': [],
          'correct_guess': [],
          if (nextPlayerAndWord.word != null) ...{
            'current_word': nextPlayerAndWord.word!.toJson(),
          } else ...{
            'status': GameStatus.complete.name,
          },
        },
      );

      if (game.currentArt.isNotEmpty) {
        // add previous play to exhibits
        final doc = firebaseFirestore.collection(FirebasePaths.exhibits(game.id)).doc();
        final exhibit = ExhibitModel(
          id: doc.id,
          player: game.currentPlayer,
          word: game.currentWord,
          art: game.currentArt,
          createdAt: DateTime.now(),
        );
        unawaited(doc.set(exhibit.toJson()));
        unawaited(
          firebaseFirestore.collection(FirebasePaths.games).doc(game.id).update(
            {'num_of_arts': FieldValue.increment(1)},
          ),
        );
        unawaited(
          sendMessage(
            game: game,
            name: 'Game bot', // localized where needed
            text: game.currentWord.text,
            loc: game.currentWord.loc,
            messageType: MessageType.wordReveal,
          ),
        );
      }

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('updateNextPlayer - $e', stack: s);
      return Result.error(CustomError(message: e.toString()));
    }
  }

  /// Sends a message to the game.
  ///
  /// This method sends a message to the game's chat.
  ///
  /// Parameters:
  /// - [game]: The [GameModel] of the game to send the message to.
  /// - [text]: The text of the message.
  /// - [name]: The name of the sender.
  /// - [messageType]: The type of the message. Defaults to [MessageType.text].
  ///
  ///  Returns a [Future] containing a [Result] with a boolean value indicating the success of the operation or an error if the operation fails.
  Future<Result<bool>> sendMessage({
    required GameModel game,
    required String text,
    required String name,
    Map<String, String> loc = const {},
    MessageType messageType = MessageType.text,
  }) async {
    try {
      _logger.request('Sending message - ${FirebasePaths.messages(game.id)}');

      final doc = firebaseFirestore.collection(FirebasePaths.messages(game.id)).doc();
      final uid = firebaseAuth.currentUser!.uid;

      final message = MessageModel(
        id: doc.id,
        uid: switch (messageType) {
          MessageType.text => uid,
          _ => 'game_bot',
        },
        text: text,
        name: name,
        loc: loc,
        messageType: messageType,
        createdAt: DateTime.now(),
      );

      await doc.set(message.toJson());

      if (messageType == MessageType.correctGuess && !game.correctGuess.contains(uid)) {
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
          firebaseFirestore.collection(FirebasePaths.games).doc(game.id).update({
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

  /// Retrieves a stream of messages from the game's chat.
  ///
  /// This method fetches a stream of messages from Firestore based on the provided game ID.
  /// It maps the snapshot to a list of [MessageModel] objects and returns a stream of the messages.
  ///
  /// Parameters:
  /// - [id]: The ID of the game to fetch messages from.
  ///
  /// Returns a [Stream<List<MessageModel>>] containing the messages.
  Stream<List<MessageModel>> getMessages(String id) {
    try {
      _logger.request('Getting messages - ${FirebasePaths.messages(id)}');
      return firebaseFirestore
          .collection(FirebasePaths.messages(id))
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

  /// Reports a user for a specific reason within a game.
  ///
  /// This method logs a report against a user within a game, incrementing their report count.
  /// If the user's report count exceeds a certain threshold, their account status is updated to suspended.
  ///
  /// Parameters:
  /// - [uid]: The ID of the user being reported.
  /// - [gameId]: The ID of the game in which the report is being made.
  /// - [reason]: The reason for the report.
  ///
  /// Returns a [Future<Result<bool>>] indicating the success or failure of the operation.
  Future<Result<bool>> reportUser({
    required String uid,
    required String gameId,
    required String reason,
  }) async {
    try {
      _logger.request('Reporting user - $reason');
      final model = ReportModel(uid, gameId, reason, DateTime.now());
      await firebaseFirestore.collection(FirebasePaths.reports).doc().set(model.toJson());

      final doc = firebaseFirestore.collection(FirebasePaths.users).doc(uid);
      final data = await doc.get();
      final user = UserModel.fromJson(data.data()!);
      await firebaseFirestore.collection(FirebasePaths.users).doc(uid).update(
        {
          'report_count': FieldValue.increment(1),
          if (user.reportCount + 1 >= 5 && user.status != UserStatus.suspended) ...{
            'status': UserStatus.suspended.name,
          },
        },
      );

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('reportUser - $e', stack: s);
      return Result.error(CustomError(message: loc.reportUserErr));
    }
  }

  /// Blocks a user.
  ///
  /// This method adds the user's ID to the current user's list of blocked users.
  ///
  /// Parameters:
  /// - [uid]: The ID of the user to be blocked.
  ///
  /// Returns a [Future<Result<bool>>] indicating the success or failure of the operation.
  Future<Result<bool>> blockUser(String uid) async {
    try {
      _logger.request('Blocking user - $uid');
      await firebaseFirestore
          .collection(FirebasePaths.users)
          .doc(firebaseAuth.currentUser!.uid)
          .update(
        {
          'blocked_users': FieldValue.arrayUnion([uid]),
        },
      );

      return const Result.success(true);
    } catch (e, s) {
      _logger.error('blockUser - $e', stack: s);
      return Result.error(CustomError(message: loc.blockUserErr));
    }
  }
}
