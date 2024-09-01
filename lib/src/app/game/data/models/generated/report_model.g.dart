// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      json['uid'] as String,
      json['game_id'] as String,
      json['reason'] as String,
      DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'game_id': instance.gameId,
      'reason': instance.reason,
      'created_at': instance.createdAt.toIso8601String(),
    };
