import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/helpers/mock_data.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/view_all_button.dart';
import 'package:gocast_mobile/views/course_view/components/course_card.dart';
import 'package:gocast_mobile/views/course_view/components/course_text_card_view.dart';
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
  final bool isCourseSection; //display courses or livestreams
  final List<Course>? courses;
  final List<Stream>? streams;
  final VoidCallback onViewAll;

  const CourseSection({
    super.key,
    required this.sectionTitle,
    required this.isCourseSection,
    this.streams,
    required this.onViewAll,
    this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCourseSectionOrMessage(
            context: context,
            title: sectionTitle,
            isCourseSection: isCourseSection,
            onViewAll: onViewAll,
            courses: courses ?? MockData.mockCourses,
            streams: streams ?? [], //TODO add mock streams
          ),
        ],
      ),
    );
  }

  Widget _buildCourseSectionOrMessage({
    required BuildContext context,
    required String title,
    required bool isCourseSection,
    required VoidCallback onViewAll,
    required List<Course> courses,
    required List<Stream> streams,
  }) {
    return isCourseSection
        ? (courses.isNotEmpty
            ? _buildCourseSection(
                context: context,
                title: title,
                onViewAll: onViewAll,
                courses: courses,
              )
            : _buildNoCoursesMessage(context, title))
        : (streams.isNotEmpty
            ? _buildCourseSection(
                context: context,
                title: title,
                courses: courses,
                streams: streams,
              )
            : _buildNoCoursesMessage(context, title));
  }

  Widget _buildCourseSection({
    required BuildContext context,
    required String title,
    VoidCallback? onViewAll,
    required List<Course> courses,
    List<Stream>? streams,
  }) {
    if (streams == null) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, title, onViewAll),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: FractionallySizedBox(
                widthFactor: 1.0,
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

                    /// End of temporary values
                    debugPrint('Course streams: ${course.streams}');

                    return CourseCardText(
                      title: course.name,
                      tumID: course.tUMOnlineIdentifier,
                      path: imagePath,
                      live: course.streams.any((stream) => stream.liveNow),
                      identifier: '',
                      semester: course.semester.teachingTerm +
                          course.semester.year.toString(),
                      courseId: course.id,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, title, onViewAll),
              SizedBox(
                height: streams != null ? 85 : 200,
                //TODO make this fit livestreams too
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: streams != null ? streams.length : courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    /// Those are temporary values until we get the real data from the API
                    final Random random = Random();
                    String imagePath;
                    List<String> imagePaths = [
                      AppImages.course1,
                      AppImages.course2,
                    ];
                    imagePath = imagePaths[random.nextInt(imagePaths.length)];

                    /// End of temporary values
                    if (streams != null) {
                      final stream = streams[index];
                      final course = courses
                          .where((course) => course.id == stream.courseID)
                          .first;
                      return CourseCard(
                        title: stream.name,
                        subtitle: course.name,
                        tumID: course.tUMOnlineIdentifier,
                        path: imagePath,
                        live: true,
                        //stream.liveNow, TODO BUG why is this not always true
                        courseId: course.id,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //TODO - is chat enabled in live mode
                              builder: (context) => VideoPlayerPage(
                                stream: stream,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      final course = courses[index];

                      return CourseCard(
                        title: course.name,
                        tumID: course.tUMOnlineIdentifier,
                        path: imagePath,
                        live: course.streams.any((stream) => stream.liveNow),
                        courseId: course.id,
                      );
                    }
                  },
                ),
              ),
            ],
          ));
    }
    ;
  }

  Row _buildSectionTitle(
    BuildContext context,
    String title,
    VoidCallback? onViewAll,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
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
// This will push the title to the start of the Row
            ],
          ),
          const SizedBox(height: 20), // Spacing between title and icon
          const Center(
// Center the icon
            child: Icon(Icons.folder_open, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 8), // Spacing between icon and text
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
          const SizedBox(height: 12), // Spacing between text and button
          Center(
// Center the button
            child: ElevatedButton(
              onPressed: () {
/* Action */
              },
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
      case 'livenow':
        return 'No courses currently live';
      case 'Public courses':
        return 'No public courses found';
      default:
        return 'Discover Courses';
    }
  }
}
