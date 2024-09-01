import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/app/game/data/models/word_model.dart';

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
    @Default([]) List<String> blockedUsers,
  }) = _PlayerModel;

  const PlayerModel._();
  factory PlayerModel.fromJson(Map<String, Object?> json) => _$PlayerModelFromJson(json);

  WordModel? get nextWord => words.where((word) => word.available).firstOrNull;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, hash_and_equals
  bool operator ==(Object other) => other is PlayerModel && uid == other.uid;
}
