import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_card.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: onRefresh,
          color: Colors.blue,
          backgroundColor: Colors.white,
          strokeWidth: 2.0,
          displacement: 20.0,
          child: SingleChildScrollView(
            child: courses.isEmpty
                ? SliverFillRemaining(
                    child: _buildPlaceholder(),
                  )
                : _buildCourseListView(context),
          ),
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

  Widget _buildCourseListView(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width >= 600 ? true : false;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: isTablet ? 600 : 400),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          final course = courses[index];
          return CourseCard(
            title: course.name,
            tumID: course.tUMOnlineIdentifier,
            path: 'assets/images/course2.png',
            live: course.streams.any((stream) => stream.liveNow),
            courseId: course.id,
            semester:
                course.semester.teachingTerm + course.semester.year.toString(),
            lastLectureId: Int64(course.lastRecordingID),
            isCourse: true,
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
      ),
    );
  }
}
