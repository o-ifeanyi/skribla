import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/game/data/models/line_model.dart';
import 'package:skribla/src/app/game/data/models/message_model.dart';
import 'package:skribla/src/app/game/data/repository/game_repository.dart';
import 'package:skribla/src/app/game/presentation/provider/game_state.dart';
import 'package:skribla/src/app/settings/presentation/provider/loc_provider.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/service/analytics.dart';
import 'package:skribla/src/core/service/haptics.dart';
import 'package:skribla/src/core/service/remote_config.dart';
import 'package:skribla/src/core/service/toast.dart';
import 'package:skribla/src/core/util/enums.dart' as enums;

part 'game_provider_ext.dart';

/// A provider class for managing game-related operations.
///
/// This class extends [StateNotifier] and manages the state of type [GameState].
/// It provides functionality for handling game-related actions such as starting a pan gesture,
/// updating the game state during a pan gesture, and managing the game stream subscription.
/// It interacts with [GameRepository] for game data operations.
///
/// Key features:
/// - Handles game-related gestures (pan start and update)
/// - Manages the game state
/// - Subscribes to the game stream for real-time updates
/// - Interacts with [GameRepository] for game data operations
///
/// Usage:
/// This provider is typically used in conjunction with Riverpod to manage
/// the game state of the application throughout the app.

class GameProvider extends StateNotifier<GameState> {
  GameProvider({
    required this.ref,
    required this.toast,
    required this.gameRepository,
  }) : super(const GameState());

  final Ref ref;
  final Toast toast;
  final GameRepository gameRepository;

  StreamSubscription<GameModel?>? _gameStreamSub;
  Timer? _updateArtTimer;
  final delay = RemoteConfig.instance.featureFlags.drawDelayMilliseconds;

  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  ConfettiController get confettiController => _confettiController;

  void onPanStart(
    BuildContext context,
    DragStartDetails details,
    BoxConstraints constraint,
  ) {
    final game = state.game;
    if (game == null) return;

    final point = _getCurrentLocalPoint(context, details.globalPosition);
    if (point == null) return;

    final exceedsBoundry = _exceedsBoundry(point, constraint);
    if (exceedsBoundry) return;

    final line = LineModel(
      [point],
      constraint.biggest,
      state.color,
      state.stroke,
    );
    final newArt = List<LineModel>.from(game.currentArt)..add(line);
    state = state.copyWith(game: game.copyWith(currentArt: newArt));
  }

  void onPanUpdate(
    BuildContext context,
    DragUpdateDetails details,
    BoxConstraints constraint,
  ) {
    final game = state.game;
    if (game == null) return;

    final point = _getCurrentLocalPoint(context, details.globalPosition);
    if (point == null) return;

    final exceedsBoundry = _exceedsBoundry(point, constraint);
    if (exceedsBoundry) return;

    // uses a delay gotten from remote config, default is 100ms
    _updateArtTimer ??= Timer.periodic(
      Duration(milliseconds: delay),
      (_) async => _updateGameArt(),
    );

    final points = List<Offset>.from(game.currentArt.last.path)..add(point);

    final line = LineModel(
      points,
      constraint.biggest,
      state.color,
      state.stroke,
    );
    final newArt = List<LineModel>.from(game.currentArt)
      ..removeLast()
      ..add(line);
    state = state.copyWith(game: game.copyWith(currentArt: newArt));
  }

  void onPanEnd() {
    _updateArtTimer?.cancel();
    _updateArtTimer = null;
    _updateGameArt();
  }

  void changeColor(Color color) {
    state = state.copyWith(color: color);
  }

  void increaseStroke() {
    state = state.copyWith(stroke: state.stroke + 2);
  }

  void decreaseStroke() {
    if (state.stroke < 3) return;
    state = state.copyWith(stroke: state.stroke - 2);
  }

  Future<bool> clearBoard() async {
    final game = state.game;
    if (game == null) return true;

    state = state.copyWith(game: game.copyWith(currentArt: []));

    final res = await gameRepository.updateGameArt(state.game!);
    return res.when(
      success: (success) => success,
      error: (error) => false,
    );
  }

  Future<bool> _updateGameArt() async {
    final game = state.game;
    if (game == null) return true;

    final res = await gameRepository.updateGameArt(game);
    return res.when(
      success: (success) => success,
      error: (error) => false,
    );
  }

  void getGameStream(String id) {
    _gameStreamSub?.cancel();
    _gameStreamSub = gameRepository.getGameStream(id).listen(
      (game) {
        if (game != null) {
          _gameChangeHandler(
            prev: state.game,
            current: game,
            update: () => state = state.copyWith(game: game),
          );
        }
      },
    );
  }

  Future<bool> leaveGame() async {
    await _gameStreamSub?.cancel();
    _gameStreamSub = null;

    final game = state.game;
    if (game == null) return true;

    final res = await gameRepository.leaveGame(
      uid: ref.read(authProvider).user?.uid ?? '',
      game: game,
    );
    return res.when(
      success: (success) {
        ref.read(timerProvider.notifier).reset();
        state = const GameState();
        return success;
      },
      error: (error) => false,
    );
  }

  Future<bool> updateNextPlayer() async {
    final game = state.game;
    if (game == null) return true;

    final res = await gameRepository.updateNextPlayer(game);
    return res.when(
      success: (success) => success,
      error: (error) => false,
    );
  }

  Future<bool> sendMessage({
    required String text,
    required String name,
  }) async {
    final game = state.game;
    if (game == null) return true;

    state = state.copyWith(status: GameStatus.sendingMessage);
    final correctGuess = game.isCorrectGuess(text.toLowerCase());

    final res = correctGuess
        ? await gameRepository.sendMessage(
            game: game,
            text: name,
            name: 'Game bot', // localized where needed
            messageType: MessageType.correctGuess,
          )
        : await gameRepository.sendMessage(game: game, text: text, name: name);
    state = state.copyWith(status: GameStatus.idle);
    return res.when(
      success: (success) {
        if (correctGuess) {
          Haptics.instance.heavyImpact();
          _confettiController.play();
        }
        return success;
      },
      error: (error) => false,
    );
  }

  Future<bool> reportUser({
    required String uid,
    required String reason,
  }) async {
    final game = state.game;
    if (game == null) return true;

    final res = await gameRepository.reportUser(uid: uid, gameId: game.id, reason: reason);
    return res.when(
      success: (success) {
        toast.showSucess(ref.read(locProvider).reportUserSuccess);
        return success;
      },
      error: (error) {
        toast.showError(error.message);
        return false;
      },
    );
  }

  Future<bool> blockUser(String uid) async {
    final game = state.game;
    if (game == null) return true;

    final res = await gameRepository.blockUser(uid);
    return res.when(
      success: (success) {
        toast.showSucess(ref.read(locProvider).blockUserSuccess);
        return success;
      },
      error: (error) {
        toast.showError(error.message);
        return false;
      },
    );
  }

  @override
  void dispose() {
    _gameStreamSub?.cancel();
    _gameStreamSub = null;
    _updateArtTimer?.cancel();
    _updateArtTimer = null;
    super.dispose();
  }
}
