import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils/courselist_screen.dart';
import 'package:gocast_mobile/View/utils/video_card_view.dart';

class PinnedCourses extends ConsumerWidget {
  const PinnedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CourseListScreen(
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
