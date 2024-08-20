import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/feature_flags.g.dart';

@JsonSerializable()
class FeatureFlags {
  const FeatureFlags({
    this.majorVersion = 0,
    this.minorVersion = 0,
    this.webDown = false,
    this.iosDown = false,
    this.androidDown = false,
    this.macDown = false,
    this.drawDelayMilliseconds = 100,
    this.coolDurationSeconds = 5,
    this.skipDurationSeconds = 7,
    this.turnDurationSeconds = 20,
    this.completeDurationSeconds = 3,
  });
  factory FeatureFlags.fromJson(Map<String, Object?> json) => _$FeatureFlagsFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureFlagsToJson(this);

  final int majorVersion;
  final int minorVersion;
  final bool webDown;
  final bool iosDown;
  final bool androidDown;
  final bool macDown;
  final int drawDelayMilliseconds;
  final int coolDurationSeconds;
  final int skipDurationSeconds;
  final int turnDurationSeconds;
  final int completeDurationSeconds;

  bool get plaformDown {
    if (kIsWeb) {
      return webDown;
    } else if (Platform.isIOS) {
      return iosDown;
    } else if (Platform.isAndroid) {
      return androidDown;
    } else if (Platform.isMacOS) {
      return macDown;
    }
    return false;
  }
}
