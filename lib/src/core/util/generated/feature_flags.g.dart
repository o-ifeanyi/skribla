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
    );

Map<String, dynamic> _$FeatureFlagsToJson(FeatureFlags instance) => <String, dynamic>{
      'major_version': instance.majorVersion,
      'minor_version': instance.minorVersion,
      'web_down': instance.webDown,
      'ios_down': instance.iosDown,
      'android_down': instance.androidDown,
      'mac_down': instance.macDown,
      'draw_delay_milliseconds': instance.drawDelayMilliseconds,
    };
