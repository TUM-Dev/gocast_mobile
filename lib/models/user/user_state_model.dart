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
  final List<FeatureNotification>? featureNotifications;
  //final List<BannerAlerts>?  //TODO
  final AppError? error;

  const UserState({
    this.isLoading = false,
    this.user,
    this.userCourses,
    this.userPinned,
    this.userSettings,
    this.userBookmarks,
    this.publicCourses,
    this.featureNotifications,
    this.error,
  });

  UserState copyWith({
    bool? isLoading,
    User? user,
    List<Course>? userCourses,
    List<Course>? userPinned,
    List<UserSetting>? userSettings,
    List<Bookmark>? userBookmarks,
    List<Course>? publicCourses,
    List<FeatureNotification>? featureNotifications,
    AppError? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      userCourses: userCourses ?? this.userCourses,
      userPinned: userPinned ?? this.userPinned,
      userSettings: userSettings ?? this.userSettings,
      userBookmarks: userBookmarks ?? this.userBookmarks,
      publicCourses: publicCourses ?? this.publicCourses,
      featureNotifications: featureNotifications ?? this.featureNotifications,
      error: error ?? this.error,
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
    List<FeatureNotification>? featureNotifications,
    AppError? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      userCourses: userCourses ?? this.userCourses,
      userPinned: userPinned ?? this.userPinned,
      userSettings: userSettings ?? this.userSettings,
      userBookmarks: userBookmarks ?? this.userBookmarks,
      publicCourses: publicCourses ?? this.publicCourses,
      featureNotifications: featureNotifications ?? this.featureNotifications,
      error: null,
    );
  }
}
