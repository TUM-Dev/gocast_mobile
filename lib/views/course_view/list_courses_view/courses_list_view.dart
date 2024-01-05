import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_card_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_text_card_view.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

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
  final Future<void> Function() onRefresh;

  const CoursesList({
    super.key,
    required this.title,
    required this.courses,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
      bottomNavigationBar: null,
      title: title,
      actions: _buildAppBarActions(context, ref),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        color: Colors.blue,
        backgroundColor: Colors.white,
        strokeWidth: 2.0,
        displacement: 20.0,
        child: CustomScrollView(
          slivers: [
            courses.isEmpty
                ? SliverFillRemaining(
                    child: _buildPlaceholder(),
                  )
                : _buildCourseListView(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context, WidgetRef ref) {
    return [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        ),
      ),
    ];
  }

  Padding _buildPlaceholder() {
    return const Padding(
      padding: AppPadding.sectionPadding,
      child: Center(child: Text('No courses found.')),
    );
  }

  Widget _buildCourseListView() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final course = courses[index];
          return CourseCardText(
            title: course.name,
            subtitle: course.slug,
            path: 'assets/images/course2.png',
            live: course.streams.any((stream) => stream.liveNow),
            courseId: course.id,
            identifier: course.tUMOnlineIdentifier,
            semester:
                course.semester.teachingTerm + course.semester.year.toString(),
          );
        },
        childCount: courses.length,
      ),
    );
  }
}
