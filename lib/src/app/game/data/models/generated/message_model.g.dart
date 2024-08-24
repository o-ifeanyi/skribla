// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      text: json['text'] as String,
      name: json['name'] as String,
      messageType: $enumDecode(_$MessageTypeEnumMap, json['message_type']),
      createdAt: DateTime.parse(json['created_at'] as String),
      loc: (json['loc'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'text': instance.text,
      'name': instance.name,
      'message_type': _$MessageTypeEnumMap[instance.messageType]!,
      'created_at': instance.createdAt.toIso8601String(),
      'loc': instance.loc,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.correctGuess: 'correctGuess',
  MessageType.wordReveal: 'wordReveal',
};
