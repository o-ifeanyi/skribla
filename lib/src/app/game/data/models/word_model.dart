import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/core/platform/others.dart'
    if (dart.library.html) 'package:skribla/src/core/platform/web.dart' as platform;

part 'generated/word_model.freezed.dart';
part 'generated/word_model.g.dart';

@freezed
class WordModel with _$WordModel {
  const factory WordModel({
    required String id,
    required DateTime createdAt,
    required String text,
    @Default(0) int index,
    @Default({}) Map<String, String> loc,
    @Default(true) bool available,
  }) = _WordModel;

  const WordModel._();

  factory WordModel.fromJson(Map<String, Object?> json) => _$WordModelFromJson(json);

  String get locText {
    final language = platform.localeName.split('_')[0];
    return loc[language] ?? text;
  }
}
