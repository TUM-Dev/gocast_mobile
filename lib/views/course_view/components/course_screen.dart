import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_card_view.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';
import 'package:gocast_mobile/views/utils/constants.dart';

/// CoursesScreen
///
/// This screen displays a list of courses.
///
/// It takes a [title] to display the title of the section and
/// dynamically generates a horizontal list of courses. This widget can be
/// reused for various course sections by providing different titles and
/// course lists.
class CoursesScreen extends ConsumerWidget {
  final String title;
  final List<Course> courses;
  final Future<void> Function() onRefresh;

  const CoursesScreen({
    super.key,
    required this.title,
    required this.courses,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
      title: 'GoCast',
      actions: _buildAppBarActions(context, ref),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(),
            courses.isEmpty ? _buildPlaceholder() : _buildCourseListView(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context, WidgetRef ref) {
    return [
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: onRefresh,
      ),
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        ),
      ),
    ];
  }

  Padding _buildSectionTitle() {
    return Padding(
      padding: AppPadding.sectionPadding,
      child: Text(
        title,
      ),
    );
  }

  Padding _buildPlaceholder() {
    return const Padding(
      padding: AppPadding.sectionPadding,
      child: Center(child: Text('No courses found.')),
    );
  }

  SizedBox _buildCourseListView() {
    return SizedBox(
      height: AppSizes.courseListHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          final course = courses[index]; // Get the course object
          return CourseCard(
            title: course.name,
            subtitle: course.slug,
            path: 'assets/images/course2.png',
          );
        },
      ),
    );
  }
}
