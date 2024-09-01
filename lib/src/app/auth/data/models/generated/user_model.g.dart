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
      reportCount: (json['report_count'] as num?)?.toInt() ?? 0,
      blockedUsers:
          (json['blocked_users'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      lastWordIndex: (json['last_word_index'] as num?)?.toInt() ?? null,
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ?? UserStatus.anonymous,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) => <String, dynamic>{
      'uid': instance.uid,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'report_count': instance.reportCount,
      'blocked_users': instance.blockedUsers,
      'last_word_index': instance.lastWordIndex,
      'status': _$UserStatusEnumMap[instance.status]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.suspended: 'suspended',
  UserStatus.anonymous: 'anonymous',
  UserStatus.verified: 'verified',
};
