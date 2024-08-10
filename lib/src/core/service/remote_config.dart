import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribla/src/core/resource/app_keys.dart';
import 'package:skribla/src/core/router/router.dart';
import 'package:skribla/src/core/router/routes.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/feature_flags.dart';

extension XPackageInfo on PackageInfo {
  int get majorVersion => int.parse(version.split('.')[0]);
  int get minorVersion => int.parse(version.split('.')[1]);
}

class RemoteConfig {
  RemoteConfig._internal();
  static final _singleton = RemoteConfig._internal();
  static RemoteConfig get instance => _singleton;

  static const _logger = Logger('RemoteConfig');

  FeatureFlags featureFlags = const FeatureFlags();

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    try {
      if (_hasBeenInitialized) return;
      _hasBeenInitialized = true;

      final doc = await FirebaseFirestore.instance.collection('_public').doc(AppKeys.flags).get();
      featureFlags = FeatureFlags.fromJson(doc.data()!);
      if (featureFlags.plaformDown) {
        Router.instance.goRouter.go(Routes.unavailable);
        return;
      }

      await _checkVersion();
    } catch (e, s) {
      _logger.error('init $e', stack: s);
    }
  }

  Future<void> _checkVersion() async {
    final pref = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();

    await pref.setString(AppKeys.version, packageInfo.version);

    if (kIsWeb) return;

    bool? forced;
    if (packageInfo.majorVersion < featureFlags.majorVersion) {
      forced = true;
    } else if (packageInfo.minorVersion < featureFlags.minorVersion) {
      forced = false;
    }
    if (forced == null) return;
    Router.instance.goRouter.go(Routes.update, extra: forced);
  }
}
