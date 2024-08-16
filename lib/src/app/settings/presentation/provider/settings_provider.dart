import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribla/src/app/settings/data/repository/settings_repository.dart';
import 'package:skribla/src/app/settings/presentation/provider/settings_state.dart';
import 'package:skribla/src/core/resource/app_keys.dart';
import 'package:skribla/src/core/service/haptics.dart';

class SettingsProvider extends StateNotifier<SettingsState> {
  SettingsProvider({
    required this.sharedPreferences,
    required this.settingsRepository,
  }) : super(
          SettingsState(
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
}
