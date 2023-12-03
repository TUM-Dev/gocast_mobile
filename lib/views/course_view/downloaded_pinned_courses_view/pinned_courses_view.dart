import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/downloaded_pinned_courses_view/content_view.dart';
import 'package:gocast_mobile/views/video_view/video_card_view.dart';

/// PinnedCourses
///
/// A widget representing the 'Pinned Courses' section of the app.
/// It utilizes the CourseContentScreen to display a list of courses
/// that the user has pinned.
class PinnedCourses extends ConsumerWidget {
  const PinnedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CourseContentScreen(
      title: 'Pinned',
      videoCards: [
        VideoCard(
          imageName: 'assets/images/course2.png',
          title: 'Computer Science [CS202]',
          date: 'July 23, 2019',
          duration: '02:00:00',
        ),
        // Add more VideoCard widgets as needed
      ],
    );
  }
}
