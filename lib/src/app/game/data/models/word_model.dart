import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/word_model.freezed.dart';
part 'generated/word_model.g.dart';

@freezed
class WordModel with _$WordModel {
  const factory WordModel({
    required String id,
    @Default('') String text,
    @Default(true) bool available,
  }) = _WordModel;

  factory WordModel.fromJson(Map<String, Object?> json) =>
      _$WordModelFromJson(json);
}
