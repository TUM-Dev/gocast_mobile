import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/pinned_handler.dart';
import 'package:gocast_mobile/models/course/pinned_course_state_model.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/utils/sort_utils.dart';
import 'package:logger/logger.dart';

class PinnedViewModel extends StateNotifier<PinnedCourseState> {
  final Logger _logger = Logger();

  final GrpcHandler _grpcHandler;

  PinnedViewModel(this._grpcHandler) : super(const PinnedCourseState());

  Future<void> fetchUserPinned() async {
    state = state.copyWith(isLoading: true);
    try {
      var courses = await PinnedHandler(_grpcHandler).fetchUserPinned();
      state = state.copyWith(userPinned: courses, isLoading: false);
      setUpDisplayedPinnedCourses(state.userPinned ?? []);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }


  Future<bool> pinCourse(int courseID) async {
    state = state.copyWith(isLoading: true);
    try {
      bool success = await PinnedHandler(_grpcHandler).pinCourse(courseID);
      if (success) {
        await fetchUserPinned();
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
      state = state.copyWith(error: e as AppError, isLoading: false);
      return false;
    }
  }

  void updateSelectedPinnedSemester(String? semester, List<Course> allCourses) {
    state = state.copyWith(selectedSemester: semester);
    updatedDisplayedPinnedCourses(
      CourseUtils.filterCoursesBySemester(
        allCourses,
        state.selectedSemester ?? 'All',
      ),
    );
  }

  void updatedDisplayedPinnedCourses(List<Course> displayedPinnedCourses) {
    state = state.copyWith(displayedPinnedCourses: displayedPinnedCourses);
  }

  void setUpDisplayedPinnedCourses(List<Course> allCourses) {
    CourseUtils.sortCourses(allCourses, 'Newest First');
    updatedDisplayedPinnedCourses(
      CourseUtils.filterCoursesBySemester(
        allCourses,
        state.selectedSemester ?? 'All',
      ),
    );
  }

  bool isCoursePinned(int id) {
    if (state.userPinned == null) {
      return false;
    }
    for (var course in state.userPinned!) {
      if (course.id == id) {
        return true;
      }
    }
    return false;
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setSemestersAsString(List<Semester> semesters) {
    state = state.copyWith(
      semestersAsString: CourseUtils.convertAndSortSemesters(semesters, true),
    );
  }

  void setSelectedSemester(String choice) {
    state = state.copyWith(selectedSemester: choice);
  }


}