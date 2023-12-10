import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
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
    // Assuming `userDownloaded` is a method or getter in your userViewModelProvider
    // that returns a list of downloaded courses.
    final userDownloaded =
        ref.watch(userViewModelProvider).downloadedCourses ?? [];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Call the method to refresh downloaded courses
          ref.read(userViewModelProvider).downloadedCourses;
        },
        child: userDownloaded.isNotEmpty
            ? ContentView(
                title: 'Downloads',
                videoCards: userDownloaded.map((course) {
                  return VideoCard(
                    imageName: 'assets/images/course1.png',
                    // Update as necessary
                    title: "${course.name} - ${course.slug}",
                    date:
                        "${course.semester.year} ${course.semester.teachingTerm}",
                    duration: course.cameraPresetPreferences,
                    onTap: () {
                      // Implement navigation to video player or course details
                    },
                  );
                }).toList(),
              )
            : BaseView(
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
              ),
      ),
    );
  }
}
