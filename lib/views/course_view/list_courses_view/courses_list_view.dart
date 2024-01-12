import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar_back_button.dart';

import 'package:gocast_mobile/views/course_view/components/course_card.dart';

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
  final TextEditingController searchController = TextEditingController();

  CoursesList({
    super.key,
    required this.title,
    required this.courses,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomSearchTopNavBarWithBackButton(
        searchController: searchController,
        onSortOptionSelected: (String choice) {
          // Implement your logic for handling sort option selection
        },
        filterOptions: [
          'Option 1',
          'Option 2'
        ], // Replace with your actual filter options
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        color: Colors.blue,
        backgroundColor: Colors.white,
        strokeWidth: 2.0,
        displacement: 20.0,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            courses.isEmpty
                ? SliverFillRemaining(child: _buildPlaceholder())
                : _buildCourseListView(),
          ],
        ),
      ),
    );
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
          return CourseCard(
            title: course.name,
            subtitle: course.slug,
            path: 'assets/images/course2.png',
            live: course.streams.any((stream) => stream.liveNow),
            courseId: course.id,
          );
        },
        childCount: courses.length,
      ),
    );
  }
}
