import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/course_view/components/courses_screen.dart';

class PublicCourses extends ConsumerStatefulWidget {
  const PublicCourses({super.key});

  @override
  PublicCoursesState createState() => PublicCoursesState();
}

class PublicCoursesState extends ConsumerState<PublicCourses> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(userViewModelProvider).publicCourses,
    );
  }

  @override
  Widget build(BuildContext context) {
    final publicCourses = ref.watch(userViewModelProvider).publicCourses ?? [];

    return CoursesScreen(
      title: 'Public Courses',
      courses: publicCourses,
      onRefresh: () async {
        ref.read(userViewModelProvider).publicCourses;
      },
    );
  }
}
