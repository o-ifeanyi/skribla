import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribla/src/core/resource/app_keys.dart';

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
