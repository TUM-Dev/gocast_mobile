import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/auth_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/bookmarks_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/course_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/pinned_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/user_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends StateNotifier<UserState> {
  final Logger _logger = Logger();

  final GrpcHandler _grpcHandler;

  UserViewModel(this._grpcHandler) : super(const UserState());

  /// Handles basic authentication.
  /// This method call the basicAuth method
  /// If the authentication is successful, it navigates to the courses screen.
  /// If the authentication fails, it shows an error message.
  Future<void> handleBasicLogin(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      await _basicAuth(email, password);
      if (state.user != null) {
        _logger.i('Logged in user ${state.user} with basic auth');
        navigatorKey.currentState?.pushNamed('/courses');
      }
    } catch (error) {
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Handles SSO authentication.
  /// This method call the ssoAuth method
  Future<void> _basicAuth(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Logging in user with email: $email');
      await AuthHandler.basicAuth(email, password);
      await fetchUser();
    } catch (error) {
      _logger.e(error);
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Handles SSO authentication.
  /// This method call the ssoAuth method
  Future<void> ssoAuth(BuildContext context, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Logging in user with SSO');
      await AuthHandler.ssoAuth(context, ref);
      await fetchUser();
      _logger.i('Logged in user with SSO');
    } catch (error) {
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchUser() async {
    try {
      _logger.i('Fetching user');
      var user = await UserHandler(_grpcHandler).fetchUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (error) {
      _logger.e(error);
      state = state.copyWith(error: error as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user courses');
      var courses = await UserHandler(_grpcHandler).fetchUserCourses();
      state = state.copyWith(userCourses: courses, isLoading: false);
    } catch (error) {
      _logger.e(error);
      state = state.copyWith(error: error as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserPinned() async {
    state = state.copyWith(isLoading: true);
    try {
      var courses = await PinnedHandler(_grpcHandler).fetchUserPinned();
      state = state.copyWith(userPinned: courses, isLoading: false);
    } catch (error) {
      _logger.e(error);
      state = state.copyWith(error: error as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserSettings() async {
    try {
      _logger.i('Fetching user settings');
      var settings = await UserHandler(_grpcHandler).fetchUserSettings();
      state = state.copyWith(userSettings: settings);
    } catch (error) {
      _logger.e(error);
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchUserBookmarks() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user bookmarks');
      var bookmarks = await BooKMarkHandler(_grpcHandler).fetchUserBookmarks();
      state = state.copyWith(userBookmarks: bookmarks, isLoading: false);
    } catch (error) {
      state = state.copyWith(error: error as AppError, isLoading: false);
    }
  }

  Future<void> fetchPublicCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching public courses');
      var courses = await CourseHandler(_grpcHandler).fetchPublicCourses();
      state = state.copyWith(publicCourses: courses, isLoading: false);
    } catch (error) {
      state = state.copyWith(error: error as AppError, isLoading: false);
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    _logger.i('Logged out user and cleared tokens.');

    state = const UserState(); // Resets the state to its initial value
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}
