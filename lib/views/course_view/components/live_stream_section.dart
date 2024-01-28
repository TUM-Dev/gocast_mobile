import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/course_view/components/course_card.dart';
import 'package:gocast_mobile/views/course_view/components/pulse_background.dart';
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
class LiveStreamSection extends StatelessWidget {
  final String sectionTitle;
  final List<Course> courses;
  final List<Stream> streams;
  final VoidCallback? onViewAll;
  final WidgetRef ref;
  final String baseUrl = 'https://live.rbg.tum.de';

  const LiveStreamSection({
    super.key,
    required this.ref,
    required this.sectionTitle,
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
          const PulsingBackground(),
          // Use the ternary conditional operator for inline conditions
          streams.isEmpty
              ? _buildNoCoursesMessage(
                  context,
                ) // If streams are empty, show no courses message
              : _buildStreamList(context), // Otherwise, show the stream list
        ],
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

  Widget _buildNoCoursesMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
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
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                _buttonText(sectionTitle),
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
