import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/view_all_button.dart';
import 'package:gocast_mobile/views/course_view/components/course_card.dart';
import 'package:gocast_mobile/views/course_view/components/pulse_background.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';

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
  final int
      sectionKind; //0 for livestreams, 1 cor mycourses, 2 for puliccourses
  final List<Course> courses;
  final List<Stream> streams;
  final VoidCallback? onViewAll;
  final WidgetRef ref;

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
          _buildCourseSectionOrMessage(
            ref: ref,
            context: context,
            title: sectionTitle,
            sectionKind: sectionKind,
            onViewAll: onViewAll,
            courses: courses,
            streams: streams,
          ),
        ],
      ),
    );
  }

  Widget _buildCourseSectionOrMessage({
    required WidgetRef ref,
    required BuildContext context,
    required String title,
    required int sectionKind,
    VoidCallback? onViewAll,
    required List<Course> courses,
    required List<Stream> streams,
  }) {
    return (streams.isNotEmpty
        ? _buildCourseSection(
            ref: ref,
            context: context,
            title: title,
            onViewAll: onViewAll,
            courses: courses,
            streams: streams,
            sectionKind: sectionKind,
          )
        : _buildNoCoursesMessage(context, title));
  }

  Widget _buildCourseSection({
    required WidgetRef ref,
    required BuildContext context,
    required String title,
    VoidCallback? onViewAll,
    required List<Course> courses,
    required List<Stream> streams,
    required int sectionKind,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionKind == 0
              ? const PulsingBackground()
              : _buildSectionTitle(
                  context,
                  title,
                  sectionKind == 1 ? Icons.school : null,
                  onViewAll,
                ),
          if (sectionKind == 1 || sectionKind == 2)
            _buildCourseList(context)
          else if (sectionKind == 0)
            _buildStreamList(context),
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
          /// Those are temporary values until we get the real data from the API
          final Random random = Random();
          final course = courses[index];
          String imagePath;
          List<String> imagePaths = [
            AppImages.course1,
            AppImages.course2,
          ];
          imagePath = imagePaths[random.nextInt(imagePaths.length)];

          return CourseCard(
            isCourse: true,
            ref: ref,
            title: course.name,
            tumID: course.tUMOnlineIdentifier,
            lastLectureId: course.lastRecordingID,
            path: imagePath,
            live: streams.any((stream) => stream.courseID == course.id),
            semester:
                course.semester.teachingTerm + course.semester.year.toString(),
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

  Widget _buildStreamList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: streams.map((stream) {
          final Random random = Random();
          String imagePath;
          List<String> imagePaths = [
            AppImages.course1,
            AppImages.course2,
          ];
          imagePath = imagePaths[random.nextInt(imagePaths.length)];

          final course =
              courses.where((course) => course.id == stream.courseID).first;

          return CourseCard(
            isCourse: false,
            ref: ref,
            title: stream.name,
            subtitle: course.name,
            tumID: course.tUMOnlineIdentifier,
            roomName: stream.roomName,
            roomNumber: stream.roomCode,
            viewerCount: stream.vodViews.toString(),
            path: imagePath,
            courseId: course.id,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(
                    stream: stream,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Row _buildSectionTitle(
    BuildContext context,
    String title,
    IconData? icon,
    VoidCallback? onViewAll,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        onViewAll != null
            ? Row(
                children: [
                  icon != null
                      ? const Row(
                          children: [
                            Icon(Icons.school),
                            SizedBox(width: 10),
                          ],
                        )
                      : const SizedBox(),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              )
            : const PulsingBackground(),
        onViewAll != null
            ? ViewAllButton(onViewAll: onViewAll)
            : const SizedBox(),
      ],
    );
  }

  Widget _buildNoCoursesMessage(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 20),
          const Center(
            child: Icon(Icons.folder_open, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'No $title found',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                _buttonText(title),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buttonText(String title) {
    switch (title) {
      case 'My courses':
        return 'Enroll in a Course';
      case 'Live Now':
        return 'No courses currently live';
      case 'Public courses':
        return 'No public courses found';
      default:
        return 'Discover Courses';
    }
  }
}
