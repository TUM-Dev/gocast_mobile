
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/downloaded_courses_view.dart';
import 'package:gocast_mobile/views/course_view/pinned_courses_view/pinned_courses_view.dart';
import 'package:gocast_mobile/views/notifications_view/notifications_overview.dart';
import 'providers.dart';
import 'views/course_view/courses_overview.dart';
class NavigationTab extends ConsumerWidget {
  const NavigationTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          Expanded(child: CourseOverview()),
          Expanded(child: DownloadedCourses()),
          PinnedCourses(),
          MyNotifications(),
        ],
      ),
    );
  }
}