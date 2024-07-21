// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineModel _$LineModelFromJson(Map<String, dynamic> json) => LineModel(
      (json['path'] as List<dynamic>)
          .map((e) =>
              const OffsetConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      const SizeConverter().fromJson(json['size'] as Map<String, dynamic>),
      const ColorConverter().fromJson(json['color'] as String),
      (json['stroke'] as num).toInt(),
    );

Map<String, dynamic> _$LineModelToJson(LineModel instance) => <String, dynamic>{
      'path': instance.path.map(const OffsetConverter().toJson).toList(),
      'size': const SizeConverter().toJson(instance.size),
      'color': const ColorConverter().toJson(instance.color),
      'stroke': instance.stroke,
    };
