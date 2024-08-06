import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribla/src/core/resource/app_keys.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/feature_flags.dart';

enum VersionValidity { valid, major, minor }

extension XPackageInfo on PackageInfo {
  String get majorVersion => version.split('.')[0];
  String get minorVersion => version.split('.')[1];
}

class RemoteConfig {
  RemoteConfig._internal();
  static final _singleton = RemoteConfig._internal();
  static RemoteConfig get instance => _singleton;

  static const _logger = Logger('RemoteConfig');
  final remoteConfig = FirebaseRemoteConfig.instance;

  FeatureFlags featureFlags = const FeatureFlags();

  Future<void> init(BuildContext context) async {
    try {
      await remoteConfig.setDefaults(featureFlags.toJson());

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 30),
          minimumFetchInterval: const Duration(minutes: 5),
        ),
      );

      await remoteConfig.fetchAndActivate();

      final data = remoteConfig.getString(AppKeys.flags);
      featureFlags = FeatureFlags.fromJson(json.decode(data) as Map<String, Object?>);

      if (featureFlags.plaformDown) {
        // navigate to service down page
        // return
      }

      unawaited(_checkVersion());
    } catch (e, s) {
      _logger.error('init $e', stack: s);
    }
  }

  Future<void> _checkVersion() async {
    final pref = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();

    await pref.setString(AppKeys.version, packageInfo.version);

    if (kIsWeb) return;

    final major = remoteConfig.getString('major_version');
    final minor = remoteConfig.getString('minor_version');

    VersionValidity validity;

    if (int.parse(packageInfo.majorVersion) < int.parse(major)) {
      validity = VersionValidity.major;
    } else if (int.parse(packageInfo.minorVersion) < int.parse(minor)) {
      validity = VersionValidity.minor;
    }
    validity = VersionValidity.valid;

    if (validity == VersionValidity.valid) return;

    // navigate to update page, minor will have a close button
  }
}
