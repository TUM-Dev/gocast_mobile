import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/course_view/components/course_card_view.dart';

import '../utils/constants.dart';
import 'components/course_screen.dart';

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
          path: AppImages.course1,
        ),
        // Add more courses as needed
      ],
    );
  }
}
