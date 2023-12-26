import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/video_view/video_card_view.dart';
import '../downloaded_courses_view/content_view.dart';

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
      () => ref.read(userViewModelProvider).userPinned,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPinned = ref.watch(userViewModelProvider).userPinned ?? [];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(userViewModelProvider).userPinned;
        },
        child: userPinned.isNotEmpty
            ? ContentView(
                title: "Pinned",
                videoCards: userPinned.map((course) {
                  return VideoCard(
                    imageName: 'assets/images/course2.png',
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
                      ref.read(userViewModelProvider).userPinned;
                    },
                  ),
                ],
                child: const Center(child: Text('No pinned courses')),
              ),
      ),
    );
  }
}
