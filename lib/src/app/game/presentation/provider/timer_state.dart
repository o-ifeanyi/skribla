import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    @Default(false) bool showCoolTimer,
    @Default(Duration.zero) Duration coolTimer,
    @Default(false) bool showSkipTimer,
    @Default(Duration.zero) Duration skipTimer,
    @Default(false) bool showTurnTimer,
    @Default(Duration.zero) Duration turnTimer,
  }) = _TimerState;
}
