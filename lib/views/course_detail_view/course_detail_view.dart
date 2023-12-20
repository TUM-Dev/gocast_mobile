import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/content_view.dart';
import 'package:gocast_mobile/views/video_view/video_card_view.dart';
import 'package:gocast_mobile/views/video_view/video_player_view.dart';

/// Course Detail View
///
/// A widget representing the 'streams of a course' section of the app.
/// It displays streams of a lecture and is accessible online
class CourseDetail extends ConsumerWidget {
  const CourseDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContentView(
      title: 'Lineare Algebra für Informatik [MA0901]',
      videoCards: [
        VideoCard(
          imageName: 'assets/images/course1.png',
          title: 'complex numbers',
          date: 'July 24, 2019',
          duration: '02:00:00',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VideoPlayerCard(
                  videoUrl: "assets/reviewTrailer.mp4",
                  title: "title",
                  date: "date",
                ),
              ),
            );
          },
        ),
        // Add more VideoCard widgets as needed
      ],
    );
  }
}
