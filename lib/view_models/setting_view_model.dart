import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/settings_handler.dart';
import 'package:gocast_mobile/models/settings/setting_state_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingViewModel extends StateNotifier<SettingState> {
  final GrpcHandler _grpcHandler;

  SettingViewModel(this._grpcHandler) : super(const SettingState());

  Future<void> fetchUserSettings() async {
    final userSettings =
        await SettingsHandler(_grpcHandler).fetchUserSettings();
    state = state.copyWith(userSettings: userSettings);
  }

  Future<void> updateUserSettings(List<UserSetting> updatedSettings) async {
    final success =
        await SettingsHandler(_grpcHandler).updateUserSettings(updatedSettings);
    if (success) {
      state = state.copyWith(userSettings: updatedSettings);
    } else {
      Logger().e('Failed to update user settings');
    }
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await loadThemePreference(prefs);
    await loadNotificationPreference(prefs);
    await fetchUserSettings();
  }

  Future<void> loadThemePreference(SharedPreferences prefs) async {
    // Default to 'system' if no preference is set
    final themePreference = prefs.getString('themeMode') ?? 'system';
    updateThemeMode(themePreference);
  }

  Future<void> saveThemePreference(String theme, WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', theme);
    updateThemeMode(theme);

    // Update the UI theme mode based on the selected preference
    ref.read(themeModeProvider.notifier).state = theme == 'dark'
        ? ThemeMode.dark
        : theme == 'light'
            ? ThemeMode.light
            : ThemeMode.system;
  }

  void updateThemeMode(String themePreference) {
    // Update the state with the new theme preference
    state = state.copyWith(
      isDarkMode: themePreference == 'dark',
      isLightMode: themePreference == 'light',
      isSystemDefault: themePreference == 'system',
    );
  }

  Future<void> loadNotificationPreference(SharedPreferences prefs) async {
    final notificationPreference = prefs.getBool('notifications') ?? true;
    state = state.copyWith(isPushNotificationsEnabled: notificationPreference);
  }

  Future<void> saveNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
    state = state.copyWith(isPushNotificationsEnabled: value);
  }

  Future<void> saveDownloadWifiOnlyPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('downloadWifiOnly', value);
    state = state.copyWith(isDownloadWithWifiOnly: value);
  }

  // This static method can stay within UserViewModel as it doesn't interact with the API
  static List<double> getDefaultSpeeds() {
    return List<double>.generate(14, (i) => (i + 1) * 0.25);
  }

  Future<void> updatePreferredGreeting(String newGreeting) async {
    await SettingsHandler(_grpcHandler).updateGreeting(newGreeting);
    await fetchUserSettings();
  }

  Future<bool> updatePreferredName(String newName) async {
    try {
      await SettingsHandler(_grpcHandler).updatePreferredName(newName);
      await fetchUserSettings();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateSelectedSpeeds(double speed, bool isSelected) async {
    await SettingsHandler(_grpcHandler)
        .updateSelectedSpeeds(speed, isSelected, state.userSettings ?? []);
    await fetchUserSettings();
  }

  List<double> parsePlaybackSpeeds() {
    return SettingsHandler(_grpcHandler)
        .parsePlaybackSpeeds(state.userSettings);
  }

  List<UserSetting>? getUserSettings() {
    return state.userSettings;
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}
