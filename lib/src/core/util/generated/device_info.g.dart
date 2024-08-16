// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      platform: json['platform'] as String,
      systemName: json['system_name'] as String?,
      appVersion: json['app_version'] as String?,
      systemVersion: json['system_version'] as String?,
      buildNumber: json['build_number'] as String?,
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) => <String, dynamic>{
      'platform': instance.platform,
      'system_name': instance.systemName,
      'system_version': instance.systemVersion,
      'app_version': instance.appVersion,
      'build_number': instance.buildNumber,
    };
