import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/message_model.g.dart';

@JsonSerializable()
class MessageModel {
  const MessageModel({
    required this.id,
    required this.uid,
    required this.text,
    required this.name,
    required this.createdAt,
    this.correctGuess = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  final String id;
  final String uid;
  final String text;
  final String? name;
  final DateTime createdAt;
  final bool correctGuess;
}
