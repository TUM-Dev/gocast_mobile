import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/downloaded_pinned_courses_view/content_view.dart';
import 'package:gocast_mobile/views/video_view/video_card_view.dart';

/// DownloadsScreen
///
/// A widget representing the 'Downloads' section of the app.
/// It displays courses that the user has downloaded for offline viewing.
/// Like PinnedCourses, it also uses the CourseContentScreen for displaying its content.
class DownloadedCourses extends ConsumerWidget {
  const DownloadedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CourseContentScreen(
      title: 'Downloads',
      videoCards: [
        VideoCard(
          imageName: 'assets/images/course1.png',
          title: 'Lineare Algebra für Informatik [MA0901]',
          date: 'July 24, 2019',
          duration: '02:00:00',
        ),
        // Add more VideoCard widgets as needed
      ],
    );
  }
}
