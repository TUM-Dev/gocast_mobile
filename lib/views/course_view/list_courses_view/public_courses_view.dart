import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';

import '../components/course_screen.dart';

/// PublicCourses Screen
/// This screen displays a list of Public Courses.
class PublicCourses extends ConsumerWidget {
  const PublicCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Schedule the data fetch after the build method using Future.microtask
    Future.microtask(() async {
      // Check if the course data is already available before fetching
      if (ref.read(userViewModelProvider).publicCourses == null) {
        await ref.read(userViewModelProvider.notifier).fetchPublicCourses();
      }
    });

    return CoursesScreen(
      title: 'Public Courses',
      courses: ref.watch(userViewModelProvider).publicCourses ?? [],
      onRefresh: () async {
        await ref.read(userViewModelProvider.notifier).fetchPublicCourses();
      },
    );
  }
}
