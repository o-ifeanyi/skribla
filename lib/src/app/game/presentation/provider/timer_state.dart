import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/timer_state.freezed.dart';

enum TimerType { cool, skip, turn, complete, idle }

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    @Default(TimerType.idle) TimerType timerType,
    @Default(Duration.zero) Duration coolDuration,
    @Default(Duration.zero) Duration skipDuration,
    @Default(Duration.zero) Duration turnDuration,
    @Default(Duration.zero) Duration completeDuration,
  }) = _TimerState;

  const TimerState._();

  bool get showTimer => timerType != TimerType.idle;
  Duration get timerDuration => switch (timerType) {
        TimerType.cool => coolDuration,
        TimerType.skip => skipDuration,
        TimerType.turn => turnDuration,
        TimerType.complete => completeDuration,
        TimerType.idle => Duration.zero,
      };
}
