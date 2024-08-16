import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/core/service/device.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:url_launcher/url_launcher.dart';

final class Support {
  Support._internal();
  static final _singleton = Support._internal();
  static const _logger = Logger('Support');

  static Support get instance => _singleton;
  final _inAppReview = InAppReview.instance;

  Future<void> requestReview() async {
    try {
      if (kIsWeb || Platform.isWindows) return;

      if (await _inAppReview.isAvailable()) {
        unawaited(_inAppReview.requestReview());
      }
    } catch (e, s) {
      _logger.error('requestReview $e', stack: s);
    }
  }

  Future<void> openStoreListing() async {
    try {
      await _inAppReview.openStoreListing(appStoreId: '6608960206');
    } catch (e, s) {
      _logger.error('openStoreListing $e', stack: s);
    }
  }

  Future<void> openStore() async {
    try {
      if (kIsWeb) return;

      final uri = Uri.parse(
        Platform.isAndroid
            ? Constants.playstore
            : (Platform.isIOS || Platform.isMacOS)
                ? Constants.appstore
                : Constants.website,
      );
      await launchUrl(uri);
    } catch (e, s) {
      _logger.error('openStore $e', stack: s);
    }
  }

  Future<void> contactSupport(UserModel? user) async {
    try {
      final info = await Device.instance.getInfo();
      final data = {
        ...info?.toJson() ?? {},
        'uid': user?.uid,
        'status': user?.status.name,
      };

      final emailUri = Uri(
        scheme: 'mailto',
        path: Constants.email,
        query: _encodeQueryParameters(<String, String>{
          'subject': 'Support/Feedback',
          'body': '\n\n\n${_formatDeviceInfo(data.removeNull)}',
        }),
      );

      await launchUrl(emailUri);
    } catch (e, s) {
      _logger.error('contactSupport $e', stack: s);
    }
  }

  Future<void> openPrivacy() async {
    try {
      await launchUrl(Uri.parse(Constants.privacy));
    } catch (e, s) {
      _logger.error('openPrivacy $e', stack: s);
    }
  }

  Future<void> openTerms() async {
    try {
      await launchUrl(Uri.parse(Constants.terms));
    } catch (e, s) {
      _logger.error('openTerms $e', stack: s);
    }
  }

  Future<bool> copyToClipboard(String value) async {
    try {
      final data = ClipboardData(text: value);
      await Clipboard.setData(data);
      return true;
    } catch (e, s) {
      _logger.error('copyToClipboard $e', stack: s);
      return false;
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  String? _formatDeviceInfo(Map<String, dynamic> params) {
    return params.entries.map((e) => '${e.key.capitalize}: ${e.value}').join('\n');
  }
}
