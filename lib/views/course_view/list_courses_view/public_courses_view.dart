import 'package:flutter/material.dart';
import 'package:gocast_mobile/models/course/course_model.dart';

import '../../utils/constants.dart';
import '../components/course_screen.dart';

/// PublicCourses Screen
/// This screen displays a list of Public Courses.
class PublicCourses extends StatelessWidget {
  const PublicCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return CoursesScreen(
      title: 'Public Courses',
      courses: [
        CourseModel(
          title: 'PSY101',
          subtitle: 'Public Psychology Course',
          imagePath: AppImages.course1,
        ),
        // Add more courses as needed
      ],
    );
  }
}
