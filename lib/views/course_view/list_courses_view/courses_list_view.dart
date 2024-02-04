import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:gocast_mobile/views/course_view/components/course_card.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';

/// CoursesScreen
///
/// This screen displays a list of courses.
///
/// It takes a [title] to display the title of the section and
/// dynamically generates a horizontal list of courses. This widget can be
/// reused for various course sections by providing different titles and
/// course lists.
class CoursesList extends ConsumerWidget {
  final String title;
  final List<Course> courses;

  const CoursesList({
    super.key,
    required this.title,
    required this.courses,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isTablet = MediaQuery.of(context).size.width >= 600;
    return courses.isEmpty
        ? _buildPlaceholder(context)
        : _buildCourseListView(context, isTablet, ref);
  }

  Padding _buildPlaceholder(BuildContext context) {
    return Padding(
      padding: AppPadding.sectionPadding,
      child:
          Center(child: Text(AppLocalizations.of(context)!.no_courses_found)),
    );
  }

  Widget _buildCourseListView(
    BuildContext context,
    bool isTablet,
    WidgetRef ref,
  ) {
    final liveStreams = ref.watch(videoViewModelProvider).liveStreams ?? [];
    var liveCourseIds = liveStreams.map((stream) => stream.courseID).toSet();
    final userPinned =
        ref.watch(pinnedCourseViewModelProvider).userPinned ?? [];
    List<Course> liveCourses =
        courses.where((course) => liveCourseIds.contains(course.id)).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        final course = courses[index];
        final isPinned = userPinned.contains(course);
        return CourseCard(
          isLoggedIn: ref.read(userViewModelProvider).user != null,
          course: course,
          isPinned: isPinned,
          onPinUnpin: (course) {
            final pinnedViewModelNotifier =
                ref.read(pinnedCourseViewModelProvider.notifier);
            if (isPinned) {
              pinnedViewModelNotifier.unpinCourse(course.id);
            } else {
              pinnedViewModelNotifier.pinCourse(course.id);
            }
          },
          title: course.name,
          live: liveCourses.contains(course),
          courseId: course.id,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetail(
                  title: course.name,
                  courseId: course.id,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
