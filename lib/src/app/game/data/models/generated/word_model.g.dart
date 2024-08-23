// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordModelImpl _$$WordModelImplFromJson(Map<String, dynamic> json) => _$WordModelImpl(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      text: json['text'] as String,
      index: (json['index'] as num?)?.toInt() ?? 0,
      loc: (json['loc'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      available: json['available'] as bool? ?? true,
    );

Map<String, dynamic> _$$WordModelImplToJson(_$WordModelImpl instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'text': instance.text,
      'index': instance.index,
      'loc': instance.loc,
      'available': instance.available,
    };
