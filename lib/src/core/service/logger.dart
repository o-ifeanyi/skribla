import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Logger {
  const Logger(this.tag);
  final String tag;

  static void log(Object x) => _print('[📝 Logger]: $x');

  void info(Object x) => _print('[🔊 $tag]: $x');

  void request(Object x) => _print('[🚀 $tag]: $x');

  void build(Object x) => _print('[🚧 $tag]: $x');

  void watch(Object x) => _print('[👀 $tag]: $x');

  void error(Object x, {StackTrace? stack}) {
    _print('[🐞 $tag]: $x${stack != null ? '\nStack: $stack' : ''}');
    if (kReleaseMode) Sentry.captureException(x, stackTrace: stack);
  }

  static void _print(String text) {
    if (kDebugMode) debugPrint(text);
  }
}
