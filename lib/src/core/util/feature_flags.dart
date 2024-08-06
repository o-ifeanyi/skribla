import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/feature_flags.freezed.dart';
part 'generated/feature_flags.g.dart';

@freezed
class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    @Default(1) int majorVersion,
    @Default(0) int minorVersion,
    @Default(false) bool webDown,
    @Default(false) bool iosDown,
    @Default(false) bool androidDown,
    @Default(false) bool macDown,
    @Default(100) int drawDelayMilliseconds,
  }) = _FeatureFlags;

  const FeatureFlags._();

  factory FeatureFlags.fromJson(Map<String, Object?> json) => _$FeatureFlagsFromJson(json);

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
