import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/settings_state.freezed.dart';

enum SettingsStatus { idle }

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SettingsStatus.idle) SettingsStatus status,
    @Default(true) bool hapticsOn,
  }) = _SettingsState;
}
