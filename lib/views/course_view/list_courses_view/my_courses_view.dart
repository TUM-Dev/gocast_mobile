import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';

import '../components/course_screen.dart';

/// MyCourses Screen
/// This screen displays a list of My Courses.
class MyCourses extends ConsumerWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Schedule the data fetch after the build method using Future.microtask
    Future.microtask(() async {
      // Check if the course data is already available before fetching
      if (ref.read(userViewModelProvider).userCourses == null) {
        await ref.read(userViewModelProvider.notifier).fetchUserCourses();
      }
    });

    return CoursesScreen(
      title: 'My Courses',
      courses: ref.watch(userViewModelProvider).userCourses ?? [],
      onRefresh: () async {
        await ref.read(userViewModelProvider.notifier).fetchUserCourses();
      },
    );
  }
}
