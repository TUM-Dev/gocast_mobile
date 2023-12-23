import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/auth_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/bookmarks_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/course_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/pinned_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/user_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:logger/logger.dart';
import 'package:gocast_mobile/base/networking/api/handler/notification_handler.dart';

class UserViewModel extends StateNotifier<UserState> {
  final Logger _logger = Logger();

  final GrpcHandler _grpcHandler;

  UserViewModel(this._grpcHandler) : super(const UserState());

  /// Handles basic authentication.
  /// If the authentication is successful, it navigates to the courses screen.
  /// If the authentication fails, it shows an error message.
  Future<void> handleBasicLogin(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Logging in user with email: $email');
      await AuthHandler.basicAuth(email, password);
      await fetchUser();
      _logger.i('Logged in user with basic auth');

      if (state.user != null) {
        _logger.i('Logged in user ${state.user} with basic auth');
        navigatorKey.currentState?.pushNamed('/courses');
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      _logger.e(e);
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
      _logger.i('Fetching user');
      var user = await UserHandler(_grpcHandler).fetchUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user courses');
      var courses = await UserHandler(_grpcHandler).fetchUserCourses();
      state = state.copyWith(userCourses: courses, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserPinned() async {
    state = state.copyWith(isLoading: true);
    try {
      var courses = await PinnedHandler(_grpcHandler).fetchUserPinned();
      state = state.copyWith(userPinned: courses, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<bool> pinCourse(int courseID) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Pinning course with id: $courseID');
      bool success = await PinnedHandler(_grpcHandler).pinCourse(courseID);
      if (success) {
        await fetchUserPinned();
        _logger.i('Course pinned successfully');
      } else {
        _logger.e('Failed to pin course');
      }
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      _logger.e('Error pinning course: $e');
      state = state.copyWith(error: e as AppError, isLoading: false);
      return false;
    }
  }

  Future<bool> unpinCourse(int courseID) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Unpinning course with id: $courseID');
      bool success = await PinnedHandler(_grpcHandler).unpinCourse(courseID);
      if (success) {
        await fetchUserPinned();
        _logger.i('Course unpinned successfully');
      } else {
        _logger.e('Failed to unpin course');
      }
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      _logger.e('Error unpinning course: $e');
      state = state.copyWith(error: e as AppError, isLoading: false);
      return false;
    }
  }

  Future<void> fetchUserSettings() async {
    try {
      _logger.i('Fetching user settings');
      var settings = await UserHandler(_grpcHandler).fetchUserSettings();
      state = state.copyWith(userSettings: settings, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchUserBookmarks() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching user bookmarks');
      var bookmarks = await BooKMarkHandler(_grpcHandler).fetchUserBookmarks();
      state = state.copyWith(userBookmarks: bookmarks, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchPublicCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching public courses');
      var courses = await CourseHandler(_grpcHandler).fetchPublicCourses();
      state = state.copyWith(publicCourses: courses, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchFeatureNotifications() async {
    try {
      _logger.i('Fetching feature notifications');
      var featureNotifications =
          await NotificationHandler(_grpcHandler).fetchFeatureNotifications();
      state = state.copyWith(
        featureNotifications: featureNotifications,
        isLoading: false,
      );
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchBannerAlerts() async {
    try {
      _logger.i('Fetching feature notifications');
      var bannerAlerts =
          await NotificationHandler(_grpcHandler).fetchBannerAlerts();
      state = state.copyWith(bannerAlerts: bannerAlerts, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> logout() async {
    await TokenHandler.deleteToken('jwt');
    state = const UserState(); // Resets the state to its initial value
    _logger.i('Logged out user and cleared tokens.');
  }

  void clearError() {
    state = state.clearError();
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}
