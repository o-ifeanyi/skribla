import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skribla/src/core/util/constants.dart';

final class Deeplink {
  Deeplink._internal();
  static final _singleton = Deeplink._internal();

  static Deeplink get instance => _singleton;

  final flavor = appFlavor ?? 'prod';

  Future<void> shareJoinLink({required String? id}) {
    final link = '${Constants.baseDeeplink}/join/$id';
    return Share.shareUri(Uri.parse(link));
  }
}
