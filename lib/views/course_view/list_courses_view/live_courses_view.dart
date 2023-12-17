import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';

import '../components/courses_screen.dart';

class LiveCourses extends ConsumerStatefulWidget {
  const LiveCourses({super.key});

  @override
  LiveCoursesState createState() => LiveCoursesState();
}

class LiveCoursesState extends ConsumerState<LiveCourses> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => ref.read(userViewModelProvider).liveCourses,
    );
  }

  @override
  Widget build(BuildContext context) {
    final liveCourses = ref.watch(userViewModelProvider).liveCourses ?? [];

    return CoursesScreen(
      title: 'Live Courses',
      courses: liveCourses,
      onRefresh: () async {
        ref.read(userViewModelProvider).liveCourses;
      },
    );
  }
}
