import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/base/networking/api/handler/auth_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/course_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/user_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:gocast_mobile/utils/sort_utils.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:logger/logger.dart';

class UserViewModel extends StateNotifier<UserState> {
  final Logger _logger = Logger();

  final GrpcHandler _grpcHandler;

  UserViewModel(this._grpcHandler) : super(const UserState()){
    // Check if the user is already logged in
    _checkToken();
  }


  /// Handles basic authentication.
  /// If the authentication is successful, it navigates to the courses screen.
  /// If the authentication fails, it shows an error message.
  Future<void> handleBasicLogin(String email, String password) async {
    state = state.reset();
    try {
      state = state.copyWith(isLoading: true);
      await AuthHandler.basicAuth(email, password);
      await fetchUser();
      if (state.user != null) {
        navigatorKey.currentState?.pushNamed('/navigationTab');
      }
    } catch (e) {
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  /// Handles SSO authentication.
  Future<void> ssoAuth(BuildContext context, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Logging in user with SSO');
      await AuthHandler.ssoAuth(context, ref);
      await fetchUser();
      _logger.i('Logged in user with SSO');
      state = state.copyWith(isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchUser() async {
    try {
      var user = await UserHandler(_grpcHandler).fetchUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }


  Future<void> logout() async {
    await TokenHandler.deleteToken('jwt');
    await TokenHandler.deleteToken('device_token');
    await TokenHandler.deleteToken('jwt_token');
    state=state.reset();
    _logger.i('Logged out user and cleared tokens.');
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  Future<void> fetchSemesters() async {
    state = state.copyWith(isLoading: true);
    try {
      var semesters = await CourseHandler(_grpcHandler).fetchSemesters();
      semesters.item1.add(semesters.item2);
      state = state.copyWith(current: semesters.item2, isLoading: false);
      state = state.copyWith(semesters: semesters.item1, isLoading: false);

      setSemestersAsString(semesters.item1);
      String current =
          "${semesters.item2.year} - ${semesters.item2.teachingTerm}";
      state = state.copyWith(currentAsString: current);
      updateSelectedSemester(current, []);
    } catch (e) {
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchPublicCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      var courses = await CourseHandler(_grpcHandler).fetchPublicCourses();
      state = state.copyWith(publicCourses: courses, isLoading: false);
      setUpDisplayedCourses(state.publicCourses ?? []);
    } catch (e) {
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      var courses = await UserHandler(_grpcHandler).fetchUserCourses();
      state = state.copyWith(userCourses: courses, isLoading: false);
      setUpDisplayedCourses(state.userCourses ?? []);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  void updateSelectedSemester(String? semester, List<Course> allCourses) {
    state = state.copyWith(selectedSemester: semester);
    updatedDisplayedCourses(
      CourseUtils.filterCoursesBySemester(
        allCourses,
        state.selectedSemester ?? 'All',
      ),
    );
  }

  void setSemestersAsString(List<Semester> semesters) {
    state = state.copyWith(
      semestersAsString: CourseUtils.convertAndSortSemesters(semesters, true),
    );
  }

  void updatedDisplayedCourses(List<Course> displayedCourses) {
    state = state.copyWith(displayedCourses: displayedCourses);
  }


  void setUpDisplayedCourses(List<Course> allCourses) {
    CourseUtils.sortCourses(allCourses, 'Newest First');
    updatedDisplayedCourses(
      CourseUtils.filterCoursesBySemester(
        allCourses,
        state.selectedSemester ?? 'All',
      ),
    );
  }

  void setSelectedSemester(String choice) {
    state = state.copyWith(selectedSemester: choice);
  }

  Future<void> _checkToken() async {
    String token = await _getToken();
    if(token.isNotEmpty && !Jwt.isExpired(token)) {
      _logger.i('Token found, fetching user: $token');
      fetchUser();
    }else {
      _logger.i('Token not found or expired');
    }
  }

  Future<String> _getToken() async {
    try {
      return await TokenHandler.loadToken('jwt');
    } catch(e){
      Logger().w("Token not found");
      return '';
    }
  }

}
