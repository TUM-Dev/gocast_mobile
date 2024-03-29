import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/utils/tools.dart';

import 'package:gocast_mobile/views/course_view/components/pulse_background.dart';
import 'package:gocast_mobile/views/course_view/components/small_stream_card.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';
import 'package:tuple/tuple.dart';

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
  final List<Tuple2<Stream, String>> streams;
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
          String imagePath;

          imagePath = _getThumbnailUrl(stream.item2);

          final course = courses
              .where((course) => course.id == stream.item1.courseID)
              .first;

          return SmallStreamCard(
            title: stream.item1.name,
            subtitle: course.name,
            tumID: Tools.extractCourseIds(course.name),
            roomName: stream.item1.roomName,
            roomNumber: stream.item1.roomCode,
            path: imagePath,
            isDownloaded: false,
            courseId: course.id,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(
                    stream: stream.item1,
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

  String _getThumbnailUrl(String thumbnail) {
    if (!thumbnail.startsWith('http')) {
      thumbnail = '$baseUrl$thumbnail';
    }
    return thumbnail;
  }
}
