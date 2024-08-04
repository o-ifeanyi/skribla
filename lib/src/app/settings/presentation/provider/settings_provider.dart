import 'package:draw_and_guess/src/app/settings/presentation/provider/settings_state.dart';
import 'package:draw_and_guess/src/core/resource/app_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends StateNotifier<SettingsState> {
  SettingsProvider({required this.sharedPreferences})
      : super(
          SettingsState(
            hapticsOn: sharedPreferences?.getBool(AppKeys.haptics) ?? true,
          ),
        );

  final SharedPreferences? sharedPreferences;

  // ignore: avoid_positional_boolean_parameters
  Future<void> toggleHaptics(bool val) async {
    await sharedPreferences?.setBool(AppKeys.haptics, val);
    state = state.copyWith(hapticsOn: val);
  }
}
