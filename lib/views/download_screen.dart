// DownloadsScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils/courselist_screen.dart';
import 'package:gocast_mobile/views/utils/video_card_view.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CourseListScreen(
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