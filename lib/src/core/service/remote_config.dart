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

/// A singleton class for managing remote configuration.
///
/// This class is responsible for fetching and managing remote configuration data, such as feature flags and version information.
/// It provides a singleton instance for accessing remote configuration throughout the app.
///
/// Key features:
/// - Fetches remote configuration data from Firestore.
/// - Manages feature flags for the application.
/// - Checks the app version against the remote configuration version.
/// - Provides a singleton instance for accessing remote configuration.
///
/// Usage:
/// This class is typically used to initialize the remote configuration at app launch.
/// The `init` method is called to fetch the remote configuration data and check the app version.
/// The `featureFlags` property can be accessed to check the current state of feature flags.
/// The `init` method also handles routing to the update screen if the app version is outdated.
///

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
      Router.instance.goRouter.go(Routes.unavailable);
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
