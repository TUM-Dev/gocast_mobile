import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

class UserState {
  bool isLoading;
  User? user;
  List<Course>? userCourses;
  List<Course>? userPinned;
  List<UserSetting>? userSettings;
  List<Bookmark>? userBookmarks;
  List<Course>? publicCourses;
  AppError? error;

  UserState({
    required this.isLoading,
    this.user,
    this.userCourses,
    this.userPinned,
    this.userSettings,
    this.userBookmarks,
    this.publicCourses,
    this.error,
  });

  // Default constructor
  UserState.defaultConstructor()
      : isLoading = false,
        user = null,
        userCourses = null,
        userPinned = null,
        userSettings = null,
        userBookmarks = null,
        publicCourses = null;

  void setUser(User user) {
    debugPrint("User set to: ${user.name}");
    this.user = user;
  }

  void setUserCourses(List<Course> userCourses) {
    this.userCourses = userCourses;
  }

  void setUserPinned(List<Course> userPinned) {
    this.userPinned = userPinned;
  }

  void setUserSettings(List<UserSetting> userSettings) {
    this.userSettings = userSettings;
  }

  void setUserBookmarks(List<Bookmark> userBookmarks) {
    this.userBookmarks = userBookmarks;
  }

  void setPublicCourses(List<Course> publicCourses) {
    this.publicCourses = publicCourses;
  }

  void removeUser() {
    user = null;
  }

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void toggleIsLoading() {
    isLoading = !isLoading;
  }

  UserState copyWith({
    bool? isLoading,
    User? user,
    List<Course>? userCourses,
    List<Course>? userPinned,
    List<UserSetting>? userSettings,
    List<Bookmark>? userBookmarks,
    List<Course>? publicCourses,
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
      error: error ?? this.error,
    );
  }
}
