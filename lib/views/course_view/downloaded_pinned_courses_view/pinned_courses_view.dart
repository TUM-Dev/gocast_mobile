import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/main.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
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
    final pinnedCourses = ref.watch(userViewModel).current.value.userPinned;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userViewModel).fetchUserPinned();
        },
        child: pinnedCourses != null && pinnedCourses.isNotEmpty
            ? CourseContentScreen(
                title: "Pinned",
                videoCards: pinnedCourses.map((course) {
                  return VideoCard(
                    imageName: 'assets/images/course2.png',
                    title: "${course.name} - ${course.slug}",
                    date:
                        "${course.semester.year} ${course.semester.teachingTerm}",
                    duration: course.cameraPresetPreferences,
                  );
                }).toList(),
                onRefresh: () async {
                  await ref.read(userViewModel).fetchUserPinned();
                },
              )
            : BaseView(
                title: '',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () async {
                      await ref.read(userViewModel).fetchUserPinned();
                    },
                  ),
                ],
                child: const Center(child: Text('No pinned courses')),
              ),
      ),
    );
  }
}
