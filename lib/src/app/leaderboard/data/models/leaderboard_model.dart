import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/leaderboard_model.freezed.dart';
part 'generated/leaderboard_model.g.dart';

@freezed
class LeaderboardModel with _$LeaderboardModel {
  const factory LeaderboardModel({
    required String uid,
    required DateTime updatedAt,
    required DateTime createdAt,
    @Default(0) int points,
  }) = _LeaderboardModel;

  factory LeaderboardModel.fromJson(Map<String, Object?> json) => _$LeaderboardModelFromJson(json);
}
