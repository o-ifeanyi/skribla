import 'dart:async';

import 'package:in_app_review/in_app_review.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

final class Support {
  Support._internal();
  static final _singleton = Support._internal();
  static const _logger = Logger('Support');

  static Support get instance => _singleton;
  final inAppReview = InAppReview.instance;

  Future<void> requestReview() async {
    try {
      if (await inAppReview.isAvailable()) {
        unawaited(inAppReview.requestReview());
      }
    } catch (e, s) {
      _logger.error('requestReview $e', stack: s);
    }
  }

  Future<void> openStoreListing() async {
    try {
      await inAppReview.openStoreListing(appStoreId: '6608960206');
    } catch (e, s) {
      _logger.error('openStoreListing $e', stack: s);
    }
  }

  Future<void> contactSupport() async {
    try {
      final emailUri = Uri(
        scheme: 'mailto',
        path: Constants.email,
        query: _encodeQueryParameters(<String, String>{
          'subject': 'Support: Skribla',
          'body': '\n\n\nDetails of the device',
        }),
      );

      await launchUrl(emailUri);
    } catch (e, s) {
      _logger.error('contactSupport $e', stack: s);
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}
