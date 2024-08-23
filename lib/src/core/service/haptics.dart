import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribla/src/core/resource/app_keys.dart';

/// A singleton class for managing haptic feedback.
///
/// This class is responsible for providing a centralized way to manage haptic feedback throughout the application.
/// It uses the Flutter's HapticFeedback class to generate haptic feedback and provides methods for different types of feedback.
/// The feedback types include light, medium, and heavy impacts, as well as a selection click.
/// The class also checks if haptic feedback is enabled in the app's settings before generating feedback.
///
/// Key features:
/// - Provides a singleton instance for accessing haptic feedback functionality throughout the app.
/// - Offers methods for different types of haptic feedback, including light, medium, and heavy impacts, as well as a selection click.
/// - Checks if haptic feedback is enabled in the app's settings before generating feedback.
///
/// Usage:
/// This class is typically used to generate haptic feedback in response to user interactions, such as button presses or other tactile events.
/// For example, when a button is pressed, the `lightImpact` method can be called to generate a light haptic feedback.
/// Similarly, other methods can be used to generate different types of feedback based on the context.
///

final class Haptics {
  Haptics._internal();
  static final _singleton = Haptics._internal();

  static Haptics get instance => _singleton;

  SharedPreferences? sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void lightImpact() {
    if (sharedPreferences?.getBool(AppKeys.haptics) ?? true) {
      HapticFeedback.lightImpact();
    }
  }

  void mediumImpact() {
    if (sharedPreferences?.getBool(AppKeys.haptics) ?? true) {
      HapticFeedback.mediumImpact();
    }
  }

  void heavyImpact() {
    if (sharedPreferences?.getBool(AppKeys.haptics) ?? true) {
      HapticFeedback.heavyImpact();
    }
  }

  void selectionClick() {
    if (sharedPreferences?.getBool(AppKeys.haptics) ?? true) {
      HapticFeedback.selectionClick();
    }
  }
}
