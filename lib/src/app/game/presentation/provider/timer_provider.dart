import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/game/presentation/provider/timer_state.dart';
import 'package:skribla/src/core/service/haptics.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/service/remote_config.dart';

class TimerProvider extends StateNotifier<TimerState> {
  TimerProvider() : super(const TimerState());

  final featureFlags = RemoteConfig.instance.featureFlags;

  Timer? _coolTimer;
  Timer? _skipTimer;
  Timer? _turnTimer;
  Timer? _completeTimer;

  void reset() {
    stopSkipTimer();
    _stopCoolTimer();
    stopTurnTimer();
    stopCompleteTimer();
    state = const TimerState();
  }

  void _stopCoolTimer() {
    if (state.timerType != TimerType.cool) return;
    Logger.log('stopCoolTimer');
    _coolTimer?.cancel();
    _coolTimer = null;
    state = state.copyWith(
      timerType: TimerType.idle,
      coolDuration: Duration.zero,
    );
  }

  Future<void> startCoolTimer({
    required VoidCallback callback,
  }) async {
    if (state.coolDuration != Duration.zero) return;
    final duration = Duration(seconds: featureFlags.coolDurationSeconds);
    Logger.log('startCoolTimer');
    state = state.copyWith(
      timerType: TimerType.cool,
      coolDuration: duration,
    );
    _coolTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('CoolTimer === ${ticker.tick}');
        if (ticker.tick >= duration.inSeconds) {
          _stopCoolTimer();
          callback.call();
        }
      },
    );
  }

  void stopSkipTimer() {
    if (state.timerType != TimerType.skip) return;
    Logger.log('stopSkipTimer');
    _skipTimer?.cancel();
    _skipTimer = null;
    state = state.copyWith(
      timerType: TimerType.idle,
      skipDuration: Duration.zero,
    );
  }

  Future<void> startSkipTimer({
    required VoidCallback callback,
    bool useHaptics = false,
  }) async {
    if (state.skipDuration != Duration.zero) return;
    final duration = Duration(seconds: featureFlags.skipDurationSeconds);
    Logger.log('startSkipTimer');
    state = state.copyWith(
      timerType: TimerType.skip,
      skipDuration: duration,
    );
    _skipTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('SkipTimer === ${ticker.tick}');
        if (useHaptics) {
          Haptics.instance.heavyImpact();
        }
        if (ticker.tick >= duration.inSeconds) {
          stopSkipTimer();
          callback.call();
        }
      },
    );
  }

  void stopTurnTimer() {
    if (state.timerType != TimerType.turn) return;
    Logger.log('stopTurnTimer');
    _turnTimer?.cancel();
    _turnTimer = null;
    state = state.copyWith(
      timerType: TimerType.idle,
      turnDuration: Duration.zero,
    );
  }

  Future<void> startTurnTimer({
    required VoidCallback callback,
    bool useHaptics = false,
  }) async {
    if (state.turnDuration != Duration.zero) return;
    final duration = Duration(seconds: featureFlags.turnDurationSeconds);

    Logger.log('startTurnTimer');
    state = state.copyWith(
      timerType: TimerType.turn,
      turnDuration: duration,
    );
    _turnTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('TurnTimer === ${ticker.tick}');
        if (useHaptics && ticker.tick >= (duration.inSeconds ~/ 2)) {
          Haptics.instance.heavyImpact();
        }
        if (ticker.tick >= duration.inSeconds) {
          stopTurnTimer();
          callback.call();
        }
      },
    );
  }

  void stopCompleteTimer() {
    if (state.timerType != TimerType.complete) return;
    Logger.log('stopCompleteTimer');
    _completeTimer?.cancel();
    _completeTimer = null;
    state = state.copyWith(
      timerType: TimerType.idle,
      completeDuration: Duration.zero,
    );
  }

  Future<void> startCompleteTimer({required VoidCallback callback}) async {
    if (state.completeDuration != Duration.zero) return;
    final duration = Duration(seconds: featureFlags.completeDurationSeconds);

    Logger.log('startCompleteTimer');
    state = state.copyWith(
      timerType: TimerType.complete,
      completeDuration: duration,
    );
    _completeTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('CompleteTimer === ${ticker.tick}');
        if (ticker.tick >= duration.inSeconds) {
          stopCompleteTimer();
          callback.call();
        }
      },
    );
  }

  @override
  void dispose() {
    reset();
    super.dispose();
  }
}
