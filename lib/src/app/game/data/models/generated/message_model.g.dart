// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      text: json['text'] as String,
      name: json['name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      correctGuess: json['correct_guess'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'text': instance.text,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'correct_guess': instance.correctGuess,
    };
