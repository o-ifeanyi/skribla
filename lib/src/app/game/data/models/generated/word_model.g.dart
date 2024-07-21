// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordModelImpl _$$WordModelImplFromJson(Map<String, dynamic> json) =>
    _$WordModelImpl(
      id: json['id'] as String,
      text: json['text'] as String? ?? '',
      available: json['available'] as bool? ?? true,
    );

Map<String, dynamic> _$$WordModelImplToJson(_$WordModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'available': instance.available,
    };
