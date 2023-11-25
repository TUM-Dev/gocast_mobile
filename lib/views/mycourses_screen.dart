import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/utils/course_card_view.dart';
import 'utils/course_screen.dart';
import 'utils/constants.dart';

// MyCourses.dart
class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoursesScreen(
      title: 'My Courses',
      courseCards: [
        CourseCard(
          title: 'PSY101',
          subtitle: 'Introduction to Psychology',
          path: courseImage1,
        ),
        // Add more courses as needed
      ],
    );
  }
}
