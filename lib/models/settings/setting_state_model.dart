import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class SettingState {
  final bool isLoading;
  final List<UserSetting>? userSettings;
  final AppError? error;
  final bool isDarkMode;
  final bool isLightMode;
  final bool isSystemDefault;
  final bool isPushNotificationsEnabled;
  final bool isDownloadWithWifiOnly;

  const SettingState({
    this.isLoading = false,
    this.userSettings,
    this.error,
    this.isDarkMode = false,
    this.isLightMode =false,
    this.isSystemDefault =true,
    this.isPushNotificationsEnabled = true,
    this.isDownloadWithWifiOnly = true,
  });

  SettingState copyWith({
    bool? isLoading,
    List<UserSetting>? userSettings,
    AppError? error,
    bool? isDarkMode,
    bool? isLightMode,
    bool? isSystemDefault,
    bool? isPushNotificationsEnabled,
    bool? isDownloadWithWifiOnly,
  }) {
    return SettingState(
      isLoading: isLoading ?? this.isLoading,
      userSettings: userSettings ?? this.userSettings,
      error: error ?? this.error,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLightMode: isLightMode ?? this.isLightMode,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
      isPushNotificationsEnabled:
      isPushNotificationsEnabled ?? this.isPushNotificationsEnabled,
      isDownloadWithWifiOnly:
      isDownloadWithWifiOnly ?? this.isDownloadWithWifiOnly,
    );
  }

  SettingState clearError({
    bool? isLoading,
    List<UserSetting>? userSettings,
    AppError? error,
    bool? isDarkMode,
    bool? isPushNotificationsEnabled,
    bool? isDownloadWithWifiOnly,
  }) {
    return SettingState(
      isLoading: isLoading ?? this.isLoading,
      userSettings: userSettings ?? this.userSettings,
      error: null,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isPushNotificationsEnabled:
      isPushNotificationsEnabled ?? this.isPushNotificationsEnabled,
      isDownloadWithWifiOnly:
      isDownloadWithWifiOnly ?? this.isDownloadWithWifiOnly,
    );
  }
}
