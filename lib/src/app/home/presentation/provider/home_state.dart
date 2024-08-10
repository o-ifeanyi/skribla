import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/home_state.freezed.dart';

enum HomeStatus { idle, creatingGame, findingGame, joiningGame }

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.idle) HomeStatus status,
  }) = _HomeState;
}
