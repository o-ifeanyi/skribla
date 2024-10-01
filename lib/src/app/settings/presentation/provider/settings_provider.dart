import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribla/src/app/settings/data/repository/settings_repository.dart';
import 'package:skribla/src/app/settings/presentation/provider/settings_state.dart';
import 'package:skribla/src/core/resource/app_keys.dart';
import 'package:skribla/src/core/service/haptics.dart';

/// A provider class for managing application settings.
///
/// This class extends [StateNotifier] and manages the state of type [SettingsState].
/// It provides functionality to toggle haptic feedback and store/retrieve settings
/// using [SharedPreferences].
///
/// The class interacts with [SettingsRepository] for potential future expansion
/// of settings-related operations.
///
/// Key features:
/// - Stores and retrieves settings using SharedPreferences
/// - Provides the current app theme
/// - Provides the current app version
///
/// Usage:
/// This provider is typically used in conjunction with Riverpod to manage
/// the state of application settings throughout the app.

class SettingsProvider extends StateNotifier<SettingsState> {
  SettingsProvider({
    required this.sharedPreferences,
    required this.settingsRepository,
  }) : super(
          SettingsState(
            theme: ThemeMode.values.firstWhere(
              (e) => e.name == sharedPreferences?.getString('currentTheme'),
              orElse: () => ThemeMode.system,
            ),
            hapticsOn: sharedPreferences?.getBool(AppKeys.haptics) ?? true,
            version: sharedPreferences?.getString(AppKeys.version) ?? '',
          ),
        );

  final SharedPreferences? sharedPreferences;
  final SettingsRepository settingsRepository;

  // ignore: avoid_positional_boolean_parameters
  Future<void> toggleHaptics(bool val) async {
    await sharedPreferences?.setBool(AppKeys.haptics, val);
    state = state.copyWith(hapticsOn: val);
    if (val) {
      Haptics.instance.mediumImpact();
    }
  }

  void setTheme(ThemeMode? mode) {
    if (mode == null) return;
    state = state.copyWith(theme: mode);
    sharedPreferences?.setString(AppKeys.theme, mode.name);
  }
}
