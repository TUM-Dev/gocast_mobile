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
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  SettingViewModel(this._grpcHandler) : super(const SettingState());

  Future<void> fetchUserSettings() async {
    try {
      _logger.i('Fetching user settings..');
      final userSettings =
      await SettingsHandler(_grpcHandler).fetchUserSettings();
      state = state.copyWith(userSettings: userSettings);
      _logger.i('User settings fetched successfully');
    } catch (e) {
      _logger.e('Error fetching user settings: $e');
    }
  }

  Future<void> updateUserSettings(List<UserSetting> updatedSettings) async {
    _logger.i('Updating user settings..');
    try {
      final success = await SettingsHandler(_grpcHandler)
          .updateUserSettings(updatedSettings);
      if (success) {
        state = state.copyWith(userSettings: updatedSettings);
        _logger.i('User settings updated successfully');
      } else {
        _logger.e('Failed to update user settings');
      }
    } catch (e) {
      _logger.e('Error updating user settings: $e');
    }
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await loadThemePreference(prefs);
    await loadNotificationPreference(prefs);
    await fetchUserSettings();
  }

  Future<void> loadThemePreference(SharedPreferences prefs) async {
    final themePreference = prefs.getString('themeMode') ?? 'light';
    state = state.copyWith(isDarkMode: themePreference == 'dark');
  }

  Future<void> saveThemePreference(String theme, WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', theme);

    state = state.copyWith(isDarkMode: theme == 'dark');

    ref.read(themeModeProvider.notifier).state =
    theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
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
    try {
      await SettingsHandler(_grpcHandler)
          .updatePreferredGreeting(newGreeting, state.userSettings ?? []);
      await fetchUserSettings();
    } catch (e) {
      _logger.e('Error updating greeting: $e');
    }
  }

  Future<bool> updatePreferredName(String newName) async {
    try {
      await SettingsHandler(_grpcHandler)
          .updatePreferredName(newName, state.userSettings ?? []);
      await fetchUserSettings();
      return true;
    } catch (e) {
      _logger.e('Error updating preferred name: $e');
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