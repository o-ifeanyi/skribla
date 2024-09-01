import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/app/leaderboard/data/models/leaderboard_model.dart';
import 'package:skribla/src/core/util/enums.dart';

part 'generated/leaderboard_state.freezed.dart';

@freezed
class LeaderboardState with _$LeaderboardState {
  const factory LeaderboardState({
    @Default(LeaderboardStatus.idle) LeaderboardStatus status,
    @Default(LeaderboardType.monthly) LeaderboardType type,
    @Default([]) List<LeaderboardModel> topThree,
  }) = _LeaderboardState;
}
