import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// A class for logging messages with different levels of severity.
///
/// This class provides a way to log messages with different levels of severity, such as info, request, build, watch, and error.
/// It also integrates with Sentry for error tracking in release mode.
///
/// Attributes:
/// - `tag`: A string identifier for the logger instance.
///
/// Methods:
/// - `log`: Logs a message with no specific level of severity.
/// - `info`, `request`, `watch`: Log messages with specific levels of severity.
/// - `error`: Logs an error message and sends it to Sentry in release mode.
/// - `_print`: A private method for printing messages to the console or sending them to Sentry.
///
/// Usage:
/// This class is typically used to log messages throughout the application. For example, to log an error, you would create an instance of this class and call the `error` method.
/// The `error` method will log the error message to the console and send it to Sentry if the app is running in release mode.
/// Similarly, other methods can be used to log messages with different levels of severity.
class Logger {
  const Logger(this.tag);
  final String tag;

  static void log(Object x) => _print('[📝 Logger]: $x');

  void info(Object x) => _print('[🔊 $tag]: $x');

  void request(Object x) => _print('[🚀 $tag]: $x');

  void watch(Object x) => _print('[👀 $tag]: $x');

  void error(Object x, {StackTrace? stack}) {
    _print('[🐞 $tag]: $x${stack != null ? '\nStack: $stack' : ''}');
    if (kReleaseMode) Sentry.captureException(x, stackTrace: stack);
  }

  static void _print(String text) {
    if (kDebugMode) debugPrint(text);
  }
}
