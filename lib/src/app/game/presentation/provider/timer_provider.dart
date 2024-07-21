import 'dart:async';

import 'package:draw_and_guess/src/app/game/presentation/provider/timer_state.dart';
import 'package:draw_and_guess/src/core/service/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerProvider extends StateNotifier<TimerState> {
  TimerProvider() : super(const TimerState());

  Timer? _coolTimer;
  Timer? _skipTimer;
  Timer? _turnTimer;

  void reset() {
    stopSkipTimer();
    _stopCoolTimer();
    _stopTurnTimer();
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
    Duration duration = const Duration(seconds: 5),
  }) async {
    if (state.showCoolTimer) return;
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
    Duration duration = const Duration(seconds: 5),
  }) async {
    if (state.showSkipTimer) return;
    Logger.log('startSkipTimer');
    state = state.copyWith(
      showSkipTimer: true,
      skipTimer: duration,
    );
    _skipTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('SkipTimer === ${duration.inSeconds}');
        if (ticker.tick == duration.inSeconds) {
          stopSkipTimer();
          callback.call();
        }
      },
    );
  }

  void _stopTurnTimer() {
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
    Duration duration = const Duration(seconds: 15),
  }) async {
    if (state.showTurnTimer) return;
    Logger.log('startTurnTimer');
    state = state.copyWith(
      showTurnTimer: true,
      turnTimer: duration,
    );
    _turnTimer = Timer.periodic(
      const Duration(seconds: 1),
      (ticker) {
        Logger.log('TurnTimer === ${duration.inSeconds}');
        if (ticker.tick == duration.inSeconds) {
          _stopTurnTimer();
          callback.call();
        }
      },
    );
  }
}
