import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_card.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_content_view.dart';

class DownloadedCourses extends ConsumerWidget {
  const DownloadedCourses({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadedVideos = ref.watch(videoViewModelProvider).downloadedVideos;

    //print('Number of downloaded videos: ${downloadedVideos.length}');

    return downloadedVideos.isNotEmpty
        ? DownloadCoursesContentView(
      title: 'Downloads',
      videoCards: downloadedVideos.entries.map((entry) {
        final int videoId = entry.key;
        final String localPath = entry.value;

        //print('Video ID: $videoId');
       // print('Local Path: $localPath');

        return VideoCard(
          duration:
          "${Random().nextInt(2).toString().padLeft(2, '0')}:${Random().nextInt(59).toString().padLeft(2, '0')}:${Random().nextInt(60).toString().padLeft(2, '0')}",
          imageName: 'assets/images/course1.png',
          // Update as necessary
          title: 'Video $videoId', // Replace with the appropriate title
          date: 'Video Date', // Replace with the appropriate date
          onTap: () {
            // Handle video tap, you can use videoId and localPath here
            //print('Video tapped: $videoId');
            //print('Local path: $localPath');
          /*  Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VideoPlayerPage(localPath: localPath),
              ),
            );
          */
          },
        );
      }).toList(),
    )
        : BaseView(
      showLeading: false,
      title: '',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            ref.read(videoViewModelProvider.notifier).fetchDownloadVideos();
          },
        ),
      ],
      child: const Center(child: Text('No downloaded courses')),
    );
  }
}
