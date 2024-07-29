// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) => _$UserModelImpl(
      uid: json['uid'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      points: (json['points'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 0,
      status: $enumDecodeNullable(_$AuthStatusEnumMap, json['status']) ?? AuthStatus.anonymous,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) => <String, dynamic>{
      'uid': instance.uid,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'points': instance.points,
      'level': instance.level,
      'status': _$AuthStatusEnumMap[instance.status]!,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.anonymous: 'anonymous',
  AuthStatus.verified: 'verified',
};
