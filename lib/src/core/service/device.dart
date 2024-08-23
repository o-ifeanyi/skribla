import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/device_info.dart';
import 'package:skribla/src/core/util/extension.dart';

/// A singleton class for managing device information.
///
/// This class is responsible for fetching and providing device information such as platform, system name, system version, app version, and build number.
/// It uses the DeviceInfoPlus library to fetch device information and provides a singleton instance for accessing device information throughout the app.
///
/// Key features:
/// - Fetches device information including platform, system name, system version, app version, and build number.
/// - Provides a singleton instance for accessing device information.
///
/// Usage:
/// This class is typically used to fetch device information when needed. For example, to log device information for debugging or analytics purposes.
/// The `getInfo` method is used to fetch the device information, which returns a `DeviceInfo` object containing the fetched information.
///

final class Device {
  Device._internal();
  static final _singleton = Device._internal();
  static const _logger = Logger('Device');

  static Device get instance => _singleton;

  Future<DeviceInfo?> getInfo() async {
    try {
      final package = await PackageInfo.fromPlatform();
      final device = DeviceInfoPlugin();
      if (kIsWeb) {
        final web = await device.webBrowserInfo;
        _logger.info(web.data);
        return DeviceInfo(
          platform: 'web',
          systemName: web.browserName.name.capitalize,
          systemVersion: web.appVersion,
          appVersion: package.version,
          buildNumber: package.buildNumber,
        );
      } else if (Platform.isAndroid) {
        final android = await device.androidInfo;
        _logger.info(android.data..remove('systemFeatures'));
        return DeviceInfo(
          platform: 'android',
          systemName: android.device,
          systemVersion: android.version.release,
          appVersion: package.version,
          buildNumber: package.buildNumber,
        );
      } else if (Platform.isIOS) {
        final ios = await device.iosInfo;
        _logger.info(ios.data);
        return DeviceInfo(
          platform: 'ios',
          systemName: ios.name,
          systemVersion: ios.systemVersion,
          appVersion: package.version,
          buildNumber: package.buildNumber,
        );
      } else if (Platform.isMacOS) {
        final macOs = await device.macOsInfo;
        _logger.info(macOs.data);
        return DeviceInfo(
          platform: 'macos',
          systemName: macOs.computerName,
          systemVersion: macOs.osRelease,
          appVersion: package.version,
          buildNumber: package.buildNumber,
        );
      }
      return null;
    } catch (e, s) {
      _logger.error('getInfo: $e', stack: s);
      return null;
    }
  }
}
