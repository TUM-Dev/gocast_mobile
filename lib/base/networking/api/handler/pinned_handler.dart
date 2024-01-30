import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:logger/logger.dart';
import 'grpc_handler.dart';

class PinnedHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  PinnedHandler(this._grpcHandler);

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
        _logger.d('User pinned: ${response.courses}');
        return response.courses;
      },
    );
  }

  /// Pins a course by its ID.
  ///
  /// Sends a gRPC call to pin the specified course. Logs the action of pinning
  /// and successful completion of the operation.
  ///
  /// [courseID]: The unique identifier of the course to be pinned.
  ///
  /// Returns [bool]: `true` if the course was pinned successfully, `false` otherwise.
  Future<bool> pinCourse(int courseID) async {
    _logger.i('Pinning course with id: $courseID');
    try {
      await _grpcHandler.callGrpcMethod(
        (client) async {
          await client.postUserPinned(PostPinnedRequest(courseID: courseID));
        },
      );
      _logger.i('Course pinned successfully');
      return true;
    } catch (e) {
      _logger.e('Error pinning course: $e');
      return false;
    }
  }

  /// Unpins a course by its ID.
  ///
  /// Sends a gRPC call to unpin the specified course. Logs the action of unpinning
  /// and successful completion of the operation.
  ///
  /// [courseID]: The unique identifier of the course to be unpinned.
  ///
  /// returns [bool]: `true` if the course was unpinned successfully, `false` otherwise.
  Future<bool> unpinCourse(int courseID) async {
    _logger.i('Unpinning course with id: $courseID');
    try {
      await _grpcHandler.callGrpcMethod(
        (client) async {
          await client
              .deleteUserPinned(DeletePinnedRequest(courseID: courseID));
        },
      );
      _logger.i('Course unpinned successfully');
      return true;
    } catch (e) {
      _logger.e('Error unpinning course: $e');
      return false;
    }
  }
}
