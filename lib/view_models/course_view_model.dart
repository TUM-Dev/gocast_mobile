import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/course_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/models/course/course_state_model.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

class CourseViewModel extends StateNotifier<CourseState> {
  final GrpcHandler _grpcHandler;

  CourseViewModel(this._grpcHandler) : super(const CourseState());

  Future<List<Course>> fetchAllCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      final courses = await CourseHandler(_grpcHandler).fetchAllCourses();
      state = state.copyWith(allCourses: courses, isLoading: false);
      return courses;
    } catch (e) {
      state = state.copyWith(error: e as AppError, isLoading: false);
      return [];
    }
  }

  Future<Course> getCourseWithID(int courseID) async {
    if (state.allCourses == null) {
      await fetchAllCourses();
    }
    var course =
        state.allCourses!.firstWhere((course) => course.id == courseID);
    state = state.copyWith(course: course);
    return course;
  }
}
