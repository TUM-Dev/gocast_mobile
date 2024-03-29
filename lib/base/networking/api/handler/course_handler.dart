import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/user_handler.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';

class CourseHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  CourseHandler(this._grpcHandler);

  /// Fetches the public courses.
  Future<List<Course>> fetchPublicCourses() async {
    _logger.i('Fetching public courses');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response =
            await client.getPublicCourses(GetPublicCoursesRequest());
        _logger.d('Public courses: ${response.courses}');
        return response.courses;
      },
    );
  }

  /// fetches the semesters and the current semester.
  Future<Tuple2<List<Semester>, Semester>> fetchSemesters() async {
    _logger.i('Fetching semesters');
    final response = await _grpcHandler.callGrpcMethod(
      (client) async {
        return await client.getSemesters(GetSemestersRequest());
      },
    );
    _logger.i('Semesters: ${response.semesters}');
    _logger.i('Current Semester: ${response.current}');
    return Tuple2(response.semesters, response.current);
  }

  /// Fetches all the courses. (public + user)
  Future<List<Course>> fetchAllCourses() async {
    List<Course> userCourses =
        await UserHandler(_grpcHandler).fetchUserCourses();
    List<Course> publicCourses =
        await CourseHandler(_grpcHandler).fetchPublicCourses();
    return [...userCourses, ...publicCourses];
  }
}
