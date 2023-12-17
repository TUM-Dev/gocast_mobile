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
  final List<Course>? liveCourses;
  final AppError? error;
  final List<Course>? downloadedCourses;

  const UserState({
    this.isLoading = false,
    this.user,
    this.userCourses,
    this.userPinned,
    this.userSettings,
    this.userBookmarks,
    this.publicCourses,
    this.liveCourses,
    this.error,
    this.downloadedCourses,
  });

  UserState copyWith({
    bool? isLoading,
    User? user,
    List<Course>? userCourses,
    List<Course>? userPinned,
    List<UserSetting>? userSettings,
    List<Bookmark>? userBookmarks,
    List<Course>? publicCourses,
    List<Course>? liveCourses,
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
      liveCourses: publicCourses ?? this.liveCourses,
      error: error ?? this.error,
      downloadedCourses: downloadedCourses ?? this.downloadedCourses,
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
    List<Course>? liveCourses,
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
      liveCourses: publicCourses ?? this.liveCourses,
      error: null,
      downloadedCourses: downloadedCourses ?? this.downloadedCourses,
    );
  }
}
