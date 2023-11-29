import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/course_view/components/course_card_view.dart';

import '../../utils/constants.dart';
import '../components/course_screen.dart';

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
          path: AppImages.course1,
        ),
        // Add more courses as needed
      ],
    );
  }
}
