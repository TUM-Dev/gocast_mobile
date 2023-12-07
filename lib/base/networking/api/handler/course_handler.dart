import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:logger/logger.dart';

class CourseHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  CourseHandler(this._grpcHandler);

  Future<List<Course>> fetchPublicCourses() async {
    _logger.i('Fetching public courses');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response =
            await client.getPublicCourses(GetPublicCoursesRequest());
        _logger.i('Public courses fetched successfully');
        _logger.d('Public courses: ${response.courses}');
        return response.courses;
      },
    );
  }

  Future<List<Semester>> fetchSemesters() async {
    _logger.i('Fetching semesters');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getSemesters(GetSemestersRequest());
        _logger.i('Semesters fetched successfully');
        _logger.d('Semesters: ${response.semesters}');
        return response.semesters;
      },
    );
  }
}
