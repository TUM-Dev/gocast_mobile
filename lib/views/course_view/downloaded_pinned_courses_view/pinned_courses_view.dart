import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/pinned_course_view.dart';
import 'package:gocast_mobile/views/course_view/downloaded_pinned_courses_view/pinned_courses_content_view.dart';

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
      () => ref.read(userViewModelProvider.notifier).fetchUserPinned(),
    );
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
            ? PinnedCoursesContentView(
                title: "Pinned Courses",
                pinnedCourseCards: userPinned.map((course) {
                  final isPinned = userPinned.any(
                    (pinnedCourse) => pinnedCourse.id == course.id,
                  );

                  return PinnedCourseCard(
                    imageName: 'assets/images/course2.png',
                    course: course,
                    onTap: () {},
                    isPinned: isPinned,
                    onPinToggle: () {
                      final viewModel =
                          ref.read(userViewModelProvider.notifier);
                      if (isPinned) {
                        viewModel.unpinCourse(course.id);
                      } else {
                        viewModel.pinCourse(course.id);
                      }
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
