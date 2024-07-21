import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/start_state.freezed.dart';

enum StartStatus { idle, findingGame }

@freezed
class StartState with _$StartState {
  const factory StartState({
    @Default(StartStatus.idle) StartStatus status,
  }) = _StartState;
}
