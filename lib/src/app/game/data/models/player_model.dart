import 'package:draw_and_guess/src/app/game/data/models/word_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/player_model.freezed.dart';
part 'generated/player_model.g.dart';

@freezed
class PlayerModel with _$PlayerModel {
  const factory PlayerModel({
    required String uid,
    required String name,
    required DateTime createdAt,
    @Default(0) int points,
    @Default([]) List<WordModel> words,
  }) = _PlayerModel;

  const PlayerModel._();
  factory PlayerModel.fromJson(Map<String, Object?> json) => _$PlayerModelFromJson(json);

  WordModel? get nextWord => words.where((word) => word.available).firstOrNull;
}
