import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';

class CourseUtils {
  static List<Course> filterCoursesBySemester(
      List<Course> courses, String selectedSemester) {
    if (selectedSemester == 'All') {
      return courses;
    } else {
      var parts = selectedSemester.split(' - ');
      var year = int.parse(parts[0]);
      var term = parts[1];

      return courses.where((course) {
        return course.semester.year == year &&
            course.semester.teachingTerm == term;
      }).toList();
    }
  }

  static List<String> convertAndSortSemesters(
      List<Semester> semesters, bool isNewestFirst) {
    List<Semester> sortedSemesters = List<Semester>.from(semesters);

    sortedSemesters.sort((a, b) {
      int yearComparison = a.year.compareTo(b.year);
      if (yearComparison != 0) {
        return isNewestFirst ? -yearComparison : yearComparison;
      }

      if (a.teachingTerm == b.teachingTerm) {
        return 0;
      }
      return a.teachingTerm == 'W' ? -1 : 1;
    });

    List<String> semesterStrings = sortedSemesters
        .map((semester) => "${semester.year} - ${semester.teachingTerm}")
        .toList();

    // Add 'All' at the beginning of the list
    semesterStrings.insert(0, 'All');

    return semesterStrings;
  }

  static void sortCourses(List<Course> courses, String sortOption) {
    if (sortOption == 'Semester') {
    } else {
      bool isNewestFirst = sortOption == 'Newest First';
      courses.sort((a, b) {
        int yearComparison = a.semester.year.compareTo(b.semester.year);
        if (yearComparison != 0) {
          return isNewestFirst ? -yearComparison : yearComparison;
        }

        if (a.semester.teachingTerm == b.semester.teachingTerm) {
          return 0;
        }
        return a.semester.teachingTerm == 'W' ? -1 : 1;
      });
    }
  }

  static List<Stream> sortStreams(List<Stream> streams, bool isNewestFirst) {
    streams.sort((a, b) {
      DateTime startA = a.start.toDateTime();
      DateTime startB = b.start.toDateTime();

      return isNewestFirst
          ? startB.compareTo(startA)
          : startA.compareTo(startB);
    });
    return streams;
  }
}
