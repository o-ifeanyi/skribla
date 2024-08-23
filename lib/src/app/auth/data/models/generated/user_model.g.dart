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
      lastWordIndex: (json['last_word_index'] as num?)?.toInt() ?? null,
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ?? UserStatus.anonymous,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) => <String, dynamic>{
      'uid': instance.uid,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'last_word_index': instance.lastWordIndex,
      'status': _$UserStatusEnumMap[instance.status]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.anonymous: 'anonymous',
  UserStatus.verified: 'verified',
};
