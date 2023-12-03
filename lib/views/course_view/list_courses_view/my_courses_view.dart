import 'package:flutter/material.dart';
import 'package:gocast_mobile/models/course/course_model.dart';

import '../../utils/constants.dart';
import '../components/course_screen.dart';

/// MyCourses Screen
/// This screen displays a list of My Courses.
///
class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return CoursesScreen(
      title: 'My Courses',
      courses: [
        CourseModel(
          title: 'PSY101',
          subtitle: 'Introduction to Psychology',
          imagePath: AppImages.course1,
        ),
        // Add more courses as needed
      ],
    );
  }
}
