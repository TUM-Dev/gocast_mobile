import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/main.dart';
import '../components/course_screen.dart';

/// MyCourses Screen
/// This screen displays a list of My Courses.
///
class MyCourses extends ConsumerWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CoursesScreen(
      title: 'My Courses',
      courses: ref.read(userViewModel).current.value.userCourses ?? [],
      onRefresh: () async {
        await ref.read(userViewModel).fetchUserCourses();
      },
    );
  }
}
