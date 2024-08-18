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

  void reset() {
    stopSkipTimer();
    _stopCoolTimer();
    stopTurnTimer();
    state = const TimerState();
  }

  void _stopCoolTimer() {
    Logger.log('stopSkipTimer');
    _coolTimer?.cancel();
    _coolTimer = null;
    state = state.copyWith(
      showCoolTimer: false,
      coolTimer: Duration.zero,
    );
  }

  Future<void> startCoolTimer({
    required VoidCallback callback,
  }) async {
    if (state.showCoolTimer) return;
    final duration = Duration(seconds: featureFlags.coolDurationSeconds);
    Logger.log('startCoolTimer');
    state = state.copyWith(
      showCoolTimer: true,
      coolTimer: duration,
    );
    _coolTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('CoolTimer === ${ticker.tick}');
        if (ticker.tick == duration.inSeconds) {
          _stopCoolTimer();
          callback.call();
        }
      },
    );
  }

  void stopSkipTimer() {
    Logger.log('stopSkipTimer');
    _skipTimer?.cancel();
    _skipTimer = null;
    state = state.copyWith(
      showSkipTimer: false,
      skipTimer: Duration.zero,
    );
  }

  Future<void> startSkipTimer({
    required VoidCallback callback,
    bool useHaptics = false,
  }) async {
    if (state.showSkipTimer) return;
    final duration = Duration(seconds: featureFlags.skipDurationSeconds);
    Logger.log('startSkipTimer');
    state = state.copyWith(
      showSkipTimer: true,
      skipTimer: duration,
    );
    _skipTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('SkipTimer === ${duration.inSeconds}');
        if (useHaptics) {
          Haptics.instance.heavyImpact();
        }
        if (ticker.tick == duration.inSeconds) {
          stopSkipTimer();
          callback.call();
        }
      },
    );
  }

  void stopTurnTimer() {
    Logger.log('stopTurnTimer');
    _turnTimer?.cancel();
    _turnTimer = null;
    state = state.copyWith(
      showTurnTimer: false,
      turnTimer: Duration.zero,
    );
  }

  Future<void> startTurnTimer({
    required VoidCallback callback,
    bool useHaptics = false,
  }) async {
    if (state.showTurnTimer) return;
    final duration = Duration(seconds: featureFlags.turnDurationSeconds);

    Logger.log('startTurnTimer');
    state = state.copyWith(
      showTurnTimer: true,
      turnTimer: duration,
    );
    _turnTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('TurnTimer === ${duration.inSeconds}');
        if (useHaptics && ticker.tick >= (duration.inSeconds ~/ 2)) {
          Haptics.instance.heavyImpact();
        }
        if (ticker.tick == duration.inSeconds) {
          stopTurnTimer();
          callback.call();
        }
      },
    );
  }
}
