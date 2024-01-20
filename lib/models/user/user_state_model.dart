import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class UserState {
  final bool isLoading;
  final User? user;
  final List<Course>? userCourses;
  final List<Course>? userPinned;
  final List<UserSetting>? userSettings;
  final List<Bookmark>? userBookmarks;
  final List<Course>? publicCourses;
  final AppError? error;
  final List<Course>? downloadedCourses;
  final bool isDarkMode;
  final bool isPushNotificationsEnabled;
  final bool isDownloadWithWifiOnly;

  const UserState({
    this.isLoading = false,
    this.user,
    this.userCourses,
    this.userPinned,
    this.userSettings,
    this.userBookmarks,
    this.publicCourses,
    this.error,
    this.downloadedCourses,
    this.isDarkMode = false,
    this.isPushNotificationsEnabled = true,
    this.isDownloadWithWifiOnly = true,
  });

  UserState copyWith({
    bool? isLoading,
    User? user,
    List<Course>? userCourses,
    List<Course>? userPinned,
    List<UserSetting>? userSettings,
    List<Bookmark>? userBookmarks,
    List<Course>? publicCourses,
    AppError? error,
    List<Course>? downloadedCourses,
    bool? isDarkMode,
    bool? isPushNotificationsEnabled,
    bool? isDownloadWithWifiOnly,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      userCourses: userCourses ?? this.userCourses,
      userPinned: userPinned ?? this.userPinned,
      userSettings: userSettings ?? this.userSettings,
      userBookmarks: userBookmarks ?? this.userBookmarks,
      publicCourses: publicCourses ?? this.publicCourses,
      error: error ?? this.error,
      downloadedCourses: downloadedCourses ?? this.downloadedCourses,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isPushNotificationsEnabled:
          isPushNotificationsEnabled ?? this.isPushNotificationsEnabled,
      isDownloadWithWifiOnly:
          isDownloadWithWifiOnly ?? this.isDownloadWithWifiOnly,
    );
  }

  UserState clearError({
    bool? isLoading,
    User? user,
    List<Course>? userCourses,
    List<Course>? userPinned,
    List<UserSetting>? userSettings,
    List<Bookmark>? userBookmarks,
    List<Course>? publicCourses,
    AppError? error,
    List<Course>? downloadedCourses,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      userCourses: userCourses ?? this.userCourses,
      userPinned: userPinned ?? this.userPinned,
      userSettings: userSettings ?? this.userSettings,
      userBookmarks: userBookmarks ?? this.userBookmarks,
      publicCourses: publicCourses ?? this.publicCourses,
      error: null,
      downloadedCourses: downloadedCourses ?? this.downloadedCourses,
    );
  }
}
