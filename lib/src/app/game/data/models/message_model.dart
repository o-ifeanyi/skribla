import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/core/platform/others.dart'
    if (dart.library.html) 'package:skribla/src/core/platform/web.dart' as platform;

part 'generated/message_model.g.dart';

enum MessageType {
  text('text'),
  correctGuess('correct_guess'),
  wordReveal('word_reveal');

  const MessageType(this.value);
  final String value;
}

@JsonSerializable()
class MessageModel {
  const MessageModel({
    required this.id,
    required this.uid,
    required this.text,
    required this.name,
    required this.messageType,
    required this.createdAt,
    this.loc = const {}, // only available for wordReveal
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  final String id;
  final String uid;
  final String text;
  final String name;
  final MessageType messageType;
  final DateTime createdAt;
  final Map<String, String> loc;

  String get locText {
    final language = platform.localeName.split('_')[0];
    return loc[language] ?? text;
  }
}
