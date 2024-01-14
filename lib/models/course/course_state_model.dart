import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class CourseState {
  final bool isLoading;
  final List<Course>? allCourses;
  final AppError? error;
  final Course? course;

  const CourseState({
    this.isLoading = false,
    this.allCourses,
    this.error,
    this.course,
  });

  CourseState copyWith({
    bool? isLoading,
    List<Course>? allCourses,
    Course? course,
    List<Stream>? allCourseStreams,
    AppError? error,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      allCourses: allCourses ?? this.allCourses,
      course: course ?? this.course,
      error: error ?? this.error,
    );
  }

  CourseState clearError() {
    return CourseState(
      isLoading: isLoading,
      allCourses: allCourses,
      course: course,
      error: null,
    );
  }

  CourseState addCourse(Course course) {
    return CourseState(
      isLoading: isLoading,
      allCourses: allCourses != null ? [...allCourses!, course] : [course],
      error: null,
    );
  }
}