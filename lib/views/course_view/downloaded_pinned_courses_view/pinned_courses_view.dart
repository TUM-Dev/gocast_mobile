import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/downloaded_pinned_courses_view/content_view.dart';
import 'package:gocast_mobile/views/video_view/video_card_view.dart';

class PinnedCourses extends ConsumerStatefulWidget {
  const PinnedCourses({super.key});

  @override
  PinnedCoursesState createState() => PinnedCoursesState();
}

class PinnedCoursesState extends ConsumerState<PinnedCourses> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(userViewModelProvider.notifier).fetchUserPinned(),);
  }

  @override
  Widget build(BuildContext context) {
    final userPinned = ref.watch(userViewModelProvider).userPinned ?? [];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userViewModelProvider.notifier).fetchUserPinned();
        },
        child: userPinned.isNotEmpty
            ? CourseContentScreen(
                title: "Pinned",
                videoCards: userPinned.map((course) {
                  return VideoCard(
                    imageName: 'assets/images/course2.png',
                    title: "${course.name} - ${course.slug}",
                    date:
                        "${course.semester.year} ${course.semester.teachingTerm}",
                    duration: course.cameraPresetPreferences,
                    onTap: () {},
                  );
                }).toList(),
                onRefresh: () async {
                  await ref
                      .read(userViewModelProvider.notifier)
                      .fetchUserPinned();
                },
              )
            : BaseView(
                title: '',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () async {
                      await ref
                          .read(userViewModelProvider.notifier)
                          .fetchUserPinned();
                    },
                  ),
                ],
                child: const Center(child: Text('No pinned courses')),
              ),
      ),
    );
  }
}
