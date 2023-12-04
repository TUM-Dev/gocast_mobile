import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:logger/logger.dart';

import 'grpc_handler.dart';

/// Handles user-related data operations.
///
/// This class is responsible for fetching and posting user-related data, such as fetching user details and updating user settings.
class UserHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  /// Creates a new instance of the `UserHandler` class.
  ///
  /// The [GrpcHandler] is required.
  UserHandler(this._grpcHandler);

  /// Fetches the current user and associated data.
  ///
  /// This method sends a `getUser` gRPC call to fetch the user details.
  ///
  /// Returns a [User] instance that represents the user details.
  Future<User> fetchUser() async {
    _logger.i('Fetching user details');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getUser(GetUserRequest());
        _logger.i('User details fetched successfully');
        _logger.d('User details: ${response.user}');
        return response.user;
      },
    );
  }

  /// Fetches the current user's courses.
  ///
  /// This method sends a `getUserCourses` gRPC call to fetch the user's
  /// courses.
  ///
  /// Returns a [List<Course>] instance that represents the user's courses.
  Future<List<Course>> fetchUserCourses() async {
    _logger.i('Fetching user courses');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getUserCourses(GetUserCoursesRequest());
        _logger.i('User courses fetched successfully');
        _logger.d('User courses: ${response.courses}');
        return response.courses;
      },
    );
  }

  /// Fetches the current user's pinned courses.
  ///
  /// This method sends a `getUserPinned` gRPC call to fetch the user's pinned
  ///  courses.
  ///
  /// Returns a [List<Course>] instance that represents the user's pinned
  /// courses.
  Future<List<Course>> fetchUserPinned() async {
    _logger.i('Fetching user pinned');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getUserPinned(GetUserPinnedRequest());
        _logger.i('User pinned fetched successfully');
        _logger.d('User pinned: ${response.courses}');
        return response.courses;
      },
    );
  }

  /// Fetches the current user's settings.
  ///
  /// This method sends a `getUserSettings` gRPC call to fetch the user's
  /// settings.
  ///
  /// Returns a [List<UserSetting>] instance that represents the user's
  /// settings.
  Future<List<UserSetting>> fetchUserSettings() async {
    _logger.i('Fetching user settings');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getUserSettings(GetUserSettingsRequest());
        _logger.i('User settings fetched successfully');
        _logger.d('User settings: ${response.userSettings}');
        return response.userSettings;
      },
    );
  }

  /// Fetches the current user's bookmarks.
  ///
  /// This method sends a `getUserBookmarks` gRPC call to fetch the user's
  /// bookmarks.
  ///
  /// Returns a [List<Bookmark>] instance that represents the user's bookmarks.
  Future<List<Bookmark>> fetchUserBookmarks() async {
    _logger.i('Fetching user bookmarks');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getUserBookmarks(GetBookmarksRequest());
        _logger.i('User bookmarks fetched successfully');
        _logger.d('User bookmarks: ${response.bookmarks}');
        return response.bookmarks;
      },
    );
  }
}
