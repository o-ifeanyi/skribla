import 'package:draw_and_guess/src/app/leaderboard/data/repository/leaderboard_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/leaderboard_state.freezed.dart';

enum LeaderboardStatus { idle, gettingUserPosition }

@freezed
class LeaderboardState with _$LeaderboardState {
  const factory LeaderboardState({
    @Default(LeaderboardStatus.idle) LeaderboardStatus status,
    @Default(LeaderboardType.monthly) LeaderboardType type,
  }) = _LeaderboardState;
}
