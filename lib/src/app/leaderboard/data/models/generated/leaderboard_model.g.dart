// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../leaderboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardModelImpl _$$LeaderboardModelImplFromJson(Map<String, dynamic> json) =>
    _$LeaderboardModelImpl(
      uid: json['uid'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      points: (json['points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$LeaderboardModelImplToJson(_$LeaderboardModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'points': instance.points,
    };
