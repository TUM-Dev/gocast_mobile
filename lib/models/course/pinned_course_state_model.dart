import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class PinnedCourseState {
  final bool? isLoading;
  final List<Course>? userPinned;
  final AppError? error;
  final List<Course>? displayedPinnedCourses;
  final List<Semester>? semesters;
  final String? selectedSemester;
  final List<String>? semestersAsString;
  final Semester? current;
  final String? currentAsString;

  const PinnedCourseState({
    this.isLoading = false,
    this.userPinned,
    this.error,
    this.displayedPinnedCourses,
    this.semesters,
    this.selectedSemester = 'All',
    this.semestersAsString,
    this.current,
    this.currentAsString,
  });

  PinnedCourseState copyWith({
    bool? isLoading,
    List<Course>? userPinned,
    AppError? error,
    List<Course>? displayedPinnedCourses,
    List<Semester>? semesters,
    String? selectedSemester,
    List<String>? semestersAsString,
    Semester? current,
    String? currentAsString,
  }) {
    return PinnedCourseState(
      isLoading: isLoading ?? this.isLoading,
      userPinned: userPinned ?? this.userPinned,
      error: error ?? this.error,
      displayedPinnedCourses: displayedPinnedCourses ?? this.displayedPinnedCourses,
      semesters: semesters ?? this.semesters,
      selectedSemester: selectedSemester ?? this.selectedSemester,
      semestersAsString: semestersAsString ?? this.semestersAsString,
      current: current ?? this.current,
      currentAsString: currentAsString ?? this.currentAsString,
    );
  }

  PinnedCourseState clearError() {
    return PinnedCourseState(
      isLoading: isLoading,
      userPinned: userPinned,
      error: null,
      displayedPinnedCourses: displayedPinnedCourses,
      semesters: semesters,
      selectedSemester: selectedSemester,
      semestersAsString: semestersAsString,
      current: current,
      currentAsString: currentAsString,
    );
  }

}