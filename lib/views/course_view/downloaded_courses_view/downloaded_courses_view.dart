import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/helpers/mock_data.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_card.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_content_view.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';
import 'package:gocast_mobile/views/video_view/video_player_controller.dart';

/// DownloadsScreen
///
/// A widget representing the 'Downloads' section of the app.
/// It displays courses that the user has downloaded for offline viewing.
/// Like PinnedCourses, it also uses the CourseContentScreen for displaying its content.
class DownloadedCourses extends ConsumerWidget {
  const DownloadedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDownloaded = ref.watch(userViewModelProvider).downloadedCourses ??
        MockData.mockDownloadedCourses;

    return userDownloaded.isNotEmpty
        ? DownloadCoursesContentView(
            title: 'Downloads',
            videoCards: userDownloaded.map((course) {
              return VideoCard(
                duration:
                    "${Random().nextInt(2).toString().padLeft(2, '0')}:${Random().nextInt(59).toString().padLeft(2, '0')}:${Random().nextInt(60).toString().padLeft(2, '0')}",
                imageName: 'assets/images/course1.png',
                // Update as necessary
                title: course.name,
                date: "${course.semester.year} ${course.semester.teachingTerm}",
                // duration: course.cameraPresetPreferences,
                onTap: () {
                  String videoTitle = course.name;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerPage(
                        videoSource: 'assets/sample.mp4',
                        title: videoTitle,
                        sourceType: VideoSourceType.asset,
                      ),
                    ),
                  );
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
                  ref.read(userViewModelProvider).downloadedCourses;
                },
              ),
            ],
            child: const Center(child: Text('No downloaded courses')),
          );
  }
}
