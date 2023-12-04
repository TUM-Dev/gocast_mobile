import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';

class UserState {
  bool isLoading;
  User? user;
  List<Course>? userCourses;
  List<Course>? userPinned;
  List<UserSetting>? userSettings;
  List<Bookmark>? userBookmarks;
  List<Course>? publicCourses;

  UserState({
    required this.isLoading,
    this.user,
    this.userCourses,
    this.userPinned,
    this.userSettings,
    this.userBookmarks,
    this.publicCourses,
  });

  // Default constructor
  UserState.defaultConstructor()
      : isLoading = false,
        user = null;

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
}
