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

  UserViewModel(this._grpcHandler) : super(UserState.defaultConstructor());

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
      await _fetchUser();
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
      _logger.i('Logging in user ${state.user} with SSO');
      await AuthHandler.ssoAuth(context, ref);
      await _fetchUser();
      _logger.i('Logged in user ${state.user} with SSO');
    } catch (error) {
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _fetchUser() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user');
      var user = await UserHandler(_grpcHandler).fetchUser();
      state = state.copyWith(user: user);
    } catch (error) {
      _logger.e(error);
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchUserCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user courses');
      var courses = await UserHandler(_grpcHandler).fetchUserCourses();
      state = state.copyWith(userCourses: courses);
    } catch (error) {
      _logger.e(error);
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchUserPinned() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user pinned');
      var courses = await PinnedHandler(_grpcHandler).fetchUserPinned();
      state = state.copyWith(userPinned: courses);
    } catch (error) {
      _logger.e(error);
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchUserSettings() async {
    state = state.copyWith(isLoading: true);
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
      state = state.copyWith(userBookmarks: bookmarks);
    } catch (error) {
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchPublicCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching public courses');
      var courses = await CourseHandler(_grpcHandler).fetchPublicCourses();
      state = state.copyWith(publicCourses: courses);
    } catch (error) {
      state = state.copyWith(error: error as AppError, isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> logout() async {
    state.removeUser();
    state = UserState.defaultConstructor();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    _logger.i('Logged out user and cleared tokens.');
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void setIsLoading(bool isLoading) {
    state.isLoading = isLoading;
  }
}
