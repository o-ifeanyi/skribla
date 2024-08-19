// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../feature_flags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureFlags _$FeatureFlagsFromJson(Map<String, dynamic> json) => FeatureFlags(
      majorVersion: (json['major_version'] as num?)?.toInt() ?? 0,
      minorVersion: (json['minor_version'] as num?)?.toInt() ?? 0,
      webDown: json['web_down'] as bool? ?? false,
      iosDown: json['ios_down'] as bool? ?? false,
      androidDown: json['android_down'] as bool? ?? false,
      macDown: json['mac_down'] as bool? ?? false,
      drawDelayMilliseconds: (json['draw_delay_milliseconds'] as num?)?.toInt() ?? 100,
      coolDurationSeconds: (json['cool_duration_seconds'] as num?)?.toInt() ?? 5,
      skipDurationSeconds: (json['skip_duration_seconds'] as num?)?.toInt() ?? 7,
      turnDurationSeconds: (json['turn_duration_seconds'] as num?)?.toInt() ?? 20,
      completeDurationSeconds: (json['complete_duration_seconds'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$FeatureFlagsToJson(FeatureFlags instance) => <String, dynamic>{
      'major_version': instance.majorVersion,
      'minor_version': instance.minorVersion,
      'web_down': instance.webDown,
      'ios_down': instance.iosDown,
      'android_down': instance.androidDown,
      'mac_down': instance.macDown,
      'draw_delay_milliseconds': instance.drawDelayMilliseconds,
      'cool_duration_seconds': instance.coolDurationSeconds,
      'skip_duration_seconds': instance.skipDurationSeconds,
      'turn_duration_seconds': instance.turnDurationSeconds,
      'complete_duration_seconds': instance.completeDurationSeconds,
    };
