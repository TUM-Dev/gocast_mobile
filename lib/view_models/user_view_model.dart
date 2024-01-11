import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/auth_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/bookmarks_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/course_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/pinned_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/settings_handler.dart';

import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/user_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:logger/logger.dart';
import 'package:gocast_mobile/base/networking/api/handler/notification_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UserViewModel extends StateNotifier<UserState> {
  final Logger _logger = Logger();

  final GrpcHandler _grpcHandler;

  UserViewModel(this._grpcHandler) : super(const UserState());

  /// Handles basic authentication.
  /// If the authentication is successful, it navigates to the courses screen.
  /// If the authentication fails, it shows an error message.
  Future<void> handleBasicLogin(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Logging in user with email: $email');
      await AuthHandler.basicAuth(email, password);
      await fetchUser();
      await fetchUserSettings();
      _logger.i('Logged in user with basic auth');

      if (state.user != null) {
        _logger.i('Logged in user ${state.user} with basic auth');
        navigatorKey.currentState?.pushNamed('/navigationTab');
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  /// Handles SSO authentication.
  Future<void> ssoAuth(BuildContext context, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Logging in user with SSO');
      await AuthHandler.ssoAuth(context, ref);
      await fetchUser();
      _logger.i('Logged in user with SSO');
      state = state.copyWith(isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchUser() async {
    try {
      _logger.i('Fetching user');
      var user = await UserHandler(_grpcHandler).fetchUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user courses');
      var courses = await UserHandler(_grpcHandler).fetchUserCourses();
      state = state.copyWith(userCourses: courses, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserPinned() async {
    state = state.copyWith(isLoading: true);
    try {
      var courses = await PinnedHandler(_grpcHandler).fetchUserPinned();
      state = state.copyWith(userPinned: courses, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<bool> pinCourse(int courseID) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Pinning course with id: $courseID');
      bool success = await PinnedHandler(_grpcHandler).pinCourse(courseID);
      if (success) {
        await fetchUserPinned();
        _logger.i('Course pinned successfully');
      } else {
        _logger.e('Failed to pin course');
      }
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      _logger.e('Error pinning course: $e');
      state = state.copyWith(error: e as AppError, isLoading: false);
      return false;
    }
  }

  Future<bool> unpinCourse(int courseID) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Unpinning course with id: $courseID');
      bool success = await PinnedHandler(_grpcHandler).unpinCourse(courseID);
      if (success) {
        await fetchUserPinned();
        _logger.i('Course unpinned successfully');
      } else {
        _logger.e('Failed to unpin course');
      }
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      _logger.e('Error unpinning course: $e');
      state = state.copyWith(error: e as AppError, isLoading: false);
      return false;
    }
  }

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

  Future<void> fetchUserBookmarks() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user bookmarks');
      var bookmarks = await BooKMarkHandler(_grpcHandler).fetchUserBookmarks();
      state = state.copyWith(userBookmarks: bookmarks, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchPublicCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching public courses');
      var courses = await CourseHandler(_grpcHandler).fetchPublicCourses();
      state = state.copyWith(publicCourses: courses, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchFeatureNotifications() async {
    try {
      _logger.i('Fetching feature notifications');
      var featureNotifications =
          await NotificationHandler(_grpcHandler).fetchFeatureNotifications();
      state = state.copyWith(
        featureNotifications: featureNotifications,
        isLoading: false,
      );
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchBannerAlerts() async {
    try {
      _logger.i('Fetching banner alerts');
      var bannerAlerts =
          await NotificationHandler(_grpcHandler).fetchBannerAlerts();
      state = state.copyWith(bannerAlerts: bannerAlerts, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> logout() async {
    await TokenHandler.deleteToken('jwt');
    state = const UserState(); // Resets the state to its initial value
    _logger.i('Logged out user and cleared tokens.');
  }

  void clearError() {
    state = state.clearError();
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
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

  isCoursePinned(int id) {
    if (state.userPinned == null) {
      return false;
    }
    for (var course in state.userPinned!) {
      if (course.id == id) {
        return true;
      }
    }
    return false;
  }
}
