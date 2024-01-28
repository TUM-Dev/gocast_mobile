import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class UserState {
  final bool isLoading;
  final User? user;
  final List<Course>? userCourses;
  final List<Bookmark>? userBookmarks;
  final List<Course>? publicCourses;
  final AppError? error;
  final List<Course>? downloadedCourses;
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
    this.userBookmarks,
    this.publicCourses,
    this.error,
    this.downloadedCourses,
    this.semesters,
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
    List<Bookmark>? userBookmarks,
    List<Course>? publicCourses,
    AppError? error,
    List<Course>? downloadedCourses,
    List<Semester>? semesters,
    String? selectedSemester,
    List<String>? semestersAsString,
    Semester? current,
    String? currentAsString,
    List<Course>? displayedCourses,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      userCourses: userCourses ?? this.userCourses,
      userBookmarks: userBookmarks ?? this.userBookmarks,
      publicCourses: publicCourses ?? this.publicCourses,
      error: error ?? this.error,
      downloadedCourses: downloadedCourses ?? this.downloadedCourses,
      semesters: semesters ?? this.semesters,
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
    List<Bookmark>? userBookmarks,
    List<Course>? publicCourses,
    AppError? error,
    List<Course>? downloadedCourses,
    List<Course>? displayedCourses,
    List<Semester>? semesters,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      userCourses: userCourses ?? this.userCourses,
      userBookmarks: userBookmarks ?? this.userBookmarks,
      publicCourses: publicCourses ?? this.publicCourses,
      error: null,
      downloadedCourses: downloadedCourses ?? this.downloadedCourses,
      semesters: semesters ?? this.semesters,
      selectedSemester: selectedSemester,
      semestersAsString: semestersAsString,
      current: current,
      currentAsString: currentAsString,
      displayedCourses: displayedCourses ?? this.displayedCourses,
    );
  }

  UserState reset() {
    return const UserState(
      isLoading: false,
      user: null,
      userCourses: null,
      userBookmarks: null,
      publicCourses: null,
      error: null,
      downloadedCourses: null,
      semesters: null,
      selectedSemester: 'All',
      semestersAsString: null,
      current: null,
      currentAsString: null,
      displayedCourses: null,
    );
  }
}
