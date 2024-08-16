import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/device_info.g.dart';

@JsonSerializable()
class DeviceInfo {
  const DeviceInfo({
    required this.platform,
    this.systemName,
    this.appVersion,
    this.systemVersion,
    this.buildNumber,
  });
  factory DeviceInfo.fromJson(Map<String, Object?> json) => _$DeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);

  final String platform;
  final String? systemName;
  final String? systemVersion;
  final String? appVersion;
  final String? buildNumber;
}
