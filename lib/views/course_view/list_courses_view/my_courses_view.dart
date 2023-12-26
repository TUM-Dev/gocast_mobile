import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/course_view/components/courses_screen.dart';

class MyCourses extends ConsumerStatefulWidget {
  const MyCourses({super.key});

  @override
  MyCoursesState createState() => MyCoursesState();
}

class MyCoursesState extends ConsumerState<MyCourses> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(userViewModelProvider).userCourses,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userCourses = ref.watch(userViewModelProvider).userCourses ?? [];

    return CoursesScreen(
      title: 'My Courses',
      courses: userCourses,
      onRefresh: () async {
        ref.read(userViewModelProvider).userCourses;
      },
    );
  }
}
