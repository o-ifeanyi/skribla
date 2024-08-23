import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/game/data/models/word_model.dart';
import 'package:skribla/src/core/resource/firebase_paths.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/service/remote_config.dart';
import 'package:skribla/src/core/util/feature_flags.dart';
import 'package:skribla/src/core/util/result.dart';

/// Repository class for handling home-related data operations.
///
/// It interacts with Firebase services (Authentication and Firestore) to
/// perform these operations.
///
/// It also utilizes [AppLocalizations] to localize the error messages.
///
/// Key methods:
/// - [createGame]: Creates a new game for a user.
/// - [findGame]: Finds an available game for a user to join.
/// - [joinGame]: Joins a specific game for the given user.
/// - [_getWords]: Fetches words for the game.
/// - [_updateUserLastWordIndex]: Updates the user's last word index.

final class HomeRepository {
  const HomeRepository({
    required this.loc,
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  final AppLocalizations loc;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  static const _logger = Logger('HomeRepository');

  FeatureFlags get _featureFlags => RemoteConfig.instance.featureFlags;

  /// Creates a new game for the given user.
  ///
  /// This method performs the following steps:
  /// 1. Fetches words for the player
  /// 2. Creates a new game document in Firestore
  /// 3. Updates the user's last word index
  ///
  /// Parameters:
  ///   [user] - The UserModel of the player creating the game
  ///
  /// Returns:
  ///   A [Result] containing the game ID if successful, or an error if not.
  Future<Result<String>> createGame(UserModel user) async {
    try {
      _logger.request('Creating game - ${user.uid}');

      // fetch player words first
      final words = await _getWords(user.lastWordIndex);

      _logger.info('Creating game');
      final player = user.toPlayer().copyWith(words: words);
      final doc = firebaseFirestore.collection(FirebasePaths.games).doc();
      final game = GameModel(
        id: doc.id,
        currentPlayer: player,
        currentWord: words.first,
        status: Status.private,
        players: [player],
        uids: [player.uid],
        online: [player.uid],
        createdAt: DateTime.now(),
      );
      await doc.set(game.toJson());

      // words.last.index becomes startIndex for next time
      unawaited(_updateUserLastWordIndex(user.uid, words.last.index));

      return Result.success(game.id);
    } on CustomError catch (e, s) {
      _logger.error('createGame - $e', stack: s);
      return Result.error(e);
    } catch (e, s) {
      _logger.error('createGame - $e', stack: s);
      return Result.error(CustomError(message: loc.createGameErr));
    }
  }

  /// Finds an existing game or creates a new one for the given user.
  ///
  /// This method performs the following steps:
  /// 1. Fetches words for the player
  /// 2. Searches for an open game
  /// 3. If no open game is found, creates a new game
  /// 4. If an open game is found, joins it
  /// 5. Updates the user's last word index
  ///
  /// Parameters:
  ///   [user] - The UserModel of the player finding/creating a game
  ///
  /// Returns:
  ///   A [Result] containing the game ID if successful, or an error if not.
  Future<Result<String>> findGame(UserModel user) async {
    try {
      _logger.request('Finding game - ${user.uid}');

      // Fetch player words first (outside the transaction as it's a separate collection)
      final words = await _getWords(user.lastWordIndex);

      return await firebaseFirestore.runTransaction<Result<String>>((transaction) async {
        // Query for open games
        final ongoingGames = await firebaseFirestore
            .collection(FirebasePaths.games)
            .where('status', isEqualTo: Status.open.name)
            .limit(1)
            .get();

        if (ongoingGames.docs.isEmpty) {
          // Create a new game if no open games are found
          _logger.info('Creating game');
          final player = user.toPlayer().copyWith(words: words);
          final doc = firebaseFirestore.collection(FirebasePaths.games).doc();
          final game = GameModel(
            id: doc.id,
            currentPlayer: player,
            currentWord: words.first,
            players: [player],
            uids: [player.uid],
            online: [player.uid],
            createdAt: DateTime.now(),
          );
          transaction.set(doc, game.toJson());
          await _updateUserLastWordIndex(user.uid, words.last.index);
          return Result.success(game.id);
        } else {
          // Join an existing game
          _logger.info('Joining game');

          final doc = ongoingGames.docs.first;
          final game = GameModel.fromJson(doc.data());
          final player = game.players.firstWhere(
            (e) => e.uid == user.uid,
            orElse: () => user.toPlayer().copyWith(words: words),
          );

          // Update the game data, ensuring uniqueness
          final updatedPlayers = {...game.players, player}.toList();
          final updatedUids = {...game.uids, player.uid}.toList();
          final updatedOnline = {...game.online, player.uid}.toList();

          // Check if the game should be closed
          final newStatus = updatedOnline.length >= game.numOfPlayers ? Status.closed : game.status;

          // Perform the update
          transaction.update(doc.reference, {
            'players': updatedPlayers.map((p) => p.toJson()).toList(),
            'uids': updatedUids,
            'online': updatedOnline,
            'status': newStatus.name,
          });
          unawaited(_updateUserLastWordIndex(user.uid, words.last.index));
          return Result.success(game.id);
        }
      });
    } on CustomError catch (e, s) {
      _logger.error('findGame - $e', stack: s);
      return Result.error(e);
    } catch (e, s) {
      _logger.error('findGame - $e', stack: s);
      return Result.error(CustomError(message: loc.findGameErr));
    }
  }

  /// Joins a specific game for the given user.
  ///
  /// This method performs the following steps:
  /// 1. Checks if the specified game exists and is joinable
  /// 2. If the game doesn't exist or isn't joinable, calls findGame instead
  /// 3. Fetches words for the player
  /// 4. Updates the game document to include the new player
  /// 5. Updates the user's last word index
  ///
  /// Parameters:
  ///   [id] - The ID of the game to join
  ///   [user] - The UserModel of the player joining the game
  ///
  /// Returns:
  ///   A [Result] containing the game ID if successful, or an error if not.
  Future<Result<String>> joinGame({required String id, required UserModel user}) async {
    try {
      _logger.request('Joining game - $id');
      final data = await firebaseFirestore.collection(FirebasePaths.games).doc(id).get();

      if (!data.exists) {
        return findGame(user);
      }

      final game = GameModel.fromJson(data.data()!);

      if (game.status == Status.closed || game.status == Status.complete) {
        return findGame(user);
      }

      // fetch player words first
      final words = await _getWords(user.lastWordIndex);

      final doc = firebaseFirestore.collection(FirebasePaths.games).doc(game.id);
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

      // words.last.index becomes startIndex for next time
      unawaited(_updateUserLastWordIndex(user.uid, words.last.index));

      return Result.success(game.id);
    } on CustomError catch (e, s) {
      _logger.error('joinGame - $e', stack: s);
      return Result.error(e);
    } catch (e, s) {
      _logger.error('joinGame - $e', stack: s);
      return Result.error(CustomError(message: loc.joinGameErr));
    }
  }

  /// Updates the user's last word index in Firestore.
  ///
  /// This method is called after fetching words to ensure the next set of words
  /// starts from where the previous set left off.
  ///
  /// Parameters:
  ///   [uid] - The user ID
  ///   [lastWordIndex] - The index of the last word fetched
  Future<void> _updateUserLastWordIndex(String uid, int lastWordIndex) {
    return firebaseFirestore.collection(FirebasePaths.users).doc(uid).update(
      {'last_word_index': lastWordIndex},
    );
  }

  /// Retrieves a list of words from Firestore for use in a game.
  ///
  /// This method fetches words from the 'words' collection,
  /// starting from the given [startIndex]. Words are returned in ascending order of their indices.
  ///
  /// If there aren't enough words from the [startIndex] to the end of the collection,
  /// it will wrap around to the beginning of the collection to fetch the required number of words.
  ///
  /// Parameters:
  ///   [startIndex] - The index to start fetching words from. Must be non-negative.
  ///
  /// Returns:
  ///   A [Future] that resolves to a [List<WordModel>] containing the fetched words.
  ///
  /// Throws:
  ///   [CustomError] if unable to fetch the required number of words after two attempts.
  ///
  /// Note: This method uses [_featureFlags] to determine how many words to fetch.
  Future<List<WordModel>> _getWords(int? startIndex) async {
    _logger.request('Getting words');

    final max = _featureFlags.totalWordsCount - _featureFlags.wordsPerGame;
    var startAt = startIndex ?? Random().nextInt(max);

    const maxAttempts = 2;

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        final words = await firebaseFirestore
            .collection(FirebasePaths.words)
            .orderBy('index')
            .startAt([startAt])
            .limit(_featureFlags.wordsPerGame)
            .withConverter(
              fromFirestore: (snapshot, _) => WordModel.fromJson(snapshot.data()!),
              toFirestore: (model, __) => model.toJson(),
            )
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList());

        if (words.length >= _featureFlags.wordsPerGame) {
          return words;
        }

        // If not enough words, try from the beginning
        startAt = 0;
      } catch (e, s) {
        _logger.error('_getWords - $e', stack: s);
        if (attempt == maxAttempts - 1) {
          throw CustomError(message: loc.fetchWordsMaxAttemptsErr(maxAttempts));
        }
      }
    }

    throw CustomError(message: loc.unexpectedFetchWordsErr);
  }
}
