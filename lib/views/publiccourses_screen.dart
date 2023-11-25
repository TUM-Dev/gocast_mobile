import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/utils/course_card_view.dart';
import 'utils/course_screen.dart';
import 'utils/constants.dart';

class PublicCourses extends StatelessWidget {
  const PublicCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoursesScreen(
      title: 'Public Courses',
      courseCards: [
        CourseCard(
          title: 'PSY101',
          subtitle: 'Public Psychology Course',
          path: courseImage1,
        ),
        // Add more courses as needed
      ],
    );
  }
}
