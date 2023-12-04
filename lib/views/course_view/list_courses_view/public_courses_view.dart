import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/main.dart';
import '../components/course_screen.dart';

/// PublicCourses Screen
/// This screen displays a list of Public Courses.
class PublicCourses extends ConsumerWidget {
  const PublicCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CoursesScreen(
      title: 'Public Courses',
      courses: ref.watch(userViewModel).current.value.publicCourses ?? [],
      onRefresh: () async {
        await ref.read(userViewModel).fetchPublicCourses();
      },
    );
  }
}
