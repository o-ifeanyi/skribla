import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/core/util/enums.dart';

part 'generated/timer_state.freezed.dart';

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
