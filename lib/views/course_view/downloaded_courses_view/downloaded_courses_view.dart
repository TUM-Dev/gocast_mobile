import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_card.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_content_view.dart';
import 'package:gocast_mobile/views/video_view/offline_video_player/offline_video_player.dart';


class DownloadedCourses extends ConsumerWidget {
  const DownloadedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadedVideos = ref.watch(downloadViewModelProvider).downloadedVideos;


    //print('Number of downloaded videos: ${downloadedVideos.length}');

    return  DownloadCoursesContentView(
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
          date: 'Video Date',
          // Replace with the appropriate date

          onTap: () {
            // Handle video tap, you can use videoId and localPath here
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OfflineVideoPlayerPage(localPath: localPath),
              ),
            );
            //TODO: repalce this with : Navigator.of(context).push(
            // TODO: MaterialPageRoute(
            // TODO: builder: (context) => OfflineVideoPlayerPage(localPath: localPath),
          },
          onDelete: () async {
            // Implement deletion logic here
            await ref.read(downloadViewModelProvider.notifier).deleteDownload(videoId);
            // For example, delete the video file and update the state
          },
        );
      }).toList(),
    );
  }
}
