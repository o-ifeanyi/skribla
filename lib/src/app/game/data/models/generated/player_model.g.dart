// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerModelImpl _$$PlayerModelImplFromJson(Map<String, dynamic> json) =>
    _$PlayerModelImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      words: (json['words'] as List<dynamic>?)
              ?.map((e) => WordModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PlayerModelImplToJson(_$PlayerModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'words': instance.words.map((e) => e.toJson()).toList(),
    };
