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
  final List<Semester>? semesters;

  final String? selectedSemester;
  final List<String>? semestersAsString;
  final Semester? current;
  final String? currentAsString;
  final List<Course>? displayedCourses;
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
    this.semesters,
    //new

    this.selectedSemester = 'All',
    this.semestersAsString,
    this.current,
    this.currentAsString,
    this.displayedCourses,
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
    List<Semester>? semesters,
    //new

      String? selectedSemester,
    List<String>? semestersAsString,
    Semester? current,
    String? currentAsString,
      List<Course>? displayedCourses}) {
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
      semesters: semesters ?? this.semesters,
      //new

      selectedSemester: selectedSemester ?? this.selectedSemester,
      semestersAsString: semestersAsString ?? this.semestersAsString,
      current: current ?? this.current,
      currentAsString: currentAsString ?? this.currentAsString,
      displayedCourses: displayedCourses ?? this.displayedCourses,
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
    List<Semester>? semesters,
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
      semesters: semesters ?? this.semesters,
    );
  }
}
