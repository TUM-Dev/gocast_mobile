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
  final List<BannerAlert>? bannerAlerts;
  final AppError? error;
  final List<Course>? downloadedCourses;

  //final List<Stream>? courseStreams; // New property for course streams
  //final List<String>? thumbnails; // New property for thumbnails

  const UserState({
    this.isLoading = false,
    this.user,
    this.userCourses,
    this.userPinned,
    this.userSettings,
    this.userBookmarks,
    this.publicCourses,
    this.featureNotifications,
    this.bannerAlerts,
    this.error,
    this.downloadedCourses,
    // this.courseStreams, //new
    // this.thumbnails, //new
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
    List<BannerAlert>? bannerAlerts,
    AppError? error,
    List<Course>? downloadedCourses,
    //List<Stream>? courseStreams, // Include in copyWith
    //List<String>? thumbnails, // New property for thumbnails
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
      bannerAlerts: bannerAlerts ?? this.bannerAlerts,
      error: error ?? this.error,
      downloadedCourses: downloadedCourses ?? this.downloadedCourses,
      //courseStreams: courseStreams ?? this.courseStreams,
      // Assign the new value
      //thumbnails: thumbnails ?? this.thumbnails,
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
    List<BannerAlert>? bannerAlerts,
    AppError? error,
    List<Course>? downloadedCourses,
    //List<Stream>? courseStreams, // New
    //List<String>? thumbnails,
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
      bannerAlerts: bannerAlerts ?? this.bannerAlerts,
      error: null,
      downloadedCourses: downloadedCourses ?? this.downloadedCourses,
      //thumbnails: thumbnails ?? this.thumbnails,
    );
  }
}
