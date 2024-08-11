import 'package:flutter/services.dart';
import 'package:skribla/env/env.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:skribla/src/core/service/toast.dart';

final class Deeplink {
  Deeplink._internal();
  static final _singleton = Deeplink._internal();
  static const _logger = Logger('Deeplink');

  static Deeplink get instance => _singleton;

  Future<void> copyJoinLink({required String? id}) async {
    try {
      final data = ClipboardData(text: '${Env.baseUrl}/join/$id');
      await Clipboard.setData(data);
      Toast.instance.showSucess('Link copied successfully', title: 'Clipboard');
    } catch (e, s) {
      _logger.error('shareJoinLink $e', stack: s);
    }
  }
}
