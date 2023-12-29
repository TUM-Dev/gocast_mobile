import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/courses_list_view.dart';

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
      () => ref.read(userViewModelProvider.notifier).fetchPublicCourses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final publicCourses = ref.watch(userViewModelProvider).publicCourses ?? [];

    return CoursesList(
      title: 'Public Courses',
      courses: publicCourses,
      onRefresh: () async {
        await ref.read(userViewModelProvider.notifier).fetchPublicCourses();
      },
    );
  }
}
