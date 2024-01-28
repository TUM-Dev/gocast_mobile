
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/section_kind.dart';
import 'package:gocast_mobile/views/components/view_all_button.dart';
import 'package:gocast_mobile/views/course_view/components/course_card.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';

/// CourseSection
///
/// A reusable stateless widget to display a specific course section.
///
/// It takes a [sectionTitle] to display the title of the section and
/// dynamically generates a horizontal list of courses. This widget can be
/// reused for various course sections by providing different titles and
/// course lists.
///
/// This widget also takes an [onViewAll] action to define the action to be
/// performed when the user taps on the View All button.
/// This widget also takes a [courses] list to display the list of courses.
/// If no courses are provided, it will display a default list of courses.
/// This widget can be reused for various course sections by providing
/// different titles, courses and onViewAll actions.
class CourseSection extends StatelessWidget {
  final String sectionTitle;
  final SectionKind
      sectionKind; //0 for livestreams, 1 cor mycourses, 2 for puliccourses
  final List<Course> courses;
  final List<Stream> streams;
  final VoidCallback? onViewAll;
  final WidgetRef ref;
  final String baseUrl = 'https://live.rbg.tum.de';

  const CourseSection({
    super.key,
    required this.ref,
    required this.sectionTitle,
    required this.sectionKind,
    required this.streams,
    this.onViewAll,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCourseSection(context),
        ],
      ),
    );
  }

  Widget _buildCourseSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCoursesTitle(context),
          courses.isEmpty
              ? _buildNoCoursesMessage(
                  context,
                ) // If streams are empty, show no courses message
              : _buildCourseList(context),
        ],
      ),
    );
  }

  Widget _buildCourseList(BuildContext context) {
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
          final userPinned =
              ref.watch(pinnedCourseViewModelProvider).userPinned ?? [];

          final isPinned = userPinned.contains(course);
          return CourseCard(
            course: course,
            isPinned: isPinned,
            onPinUnpin: (course) => _togglePin(course, isPinned),
            title: course.name,
            tumID: course.tUMOnlineIdentifier,
            live: streams.any((stream) => stream.courseID == course.id),
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
      ),
    );
  }

  Future<void> _togglePin(Course course, bool isPinned) async {
    final pinnedViewModel = ref.read(pinnedCourseViewModelProvider.notifier);
    if (isPinned) {
      await pinnedViewModel.unpinCourse(course.id);
    } else {
      await pinnedViewModel.pinCourse(course.id);
    }
    await _refreshPinnedCourses();
  }

  Future<void> _refreshPinnedCourses() async {
    await ref.read(pinnedCourseViewModelProvider.notifier).fetchUserPinned();
  }

  Widget _buildCoursesTitle(BuildContext context) {
    IconData icon =
        sectionKind == SectionKind.myCourses ? Icons.school : Icons.public;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              sectionTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        ViewAllButton(onViewAll: onViewAll),
      ],
    );
  }

  Widget _buildNoCoursesMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Icon(Icons.not_interested, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'No $sectionTitle found',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
