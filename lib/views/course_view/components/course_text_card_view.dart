import 'dart:math';

import 'package:flutter/material.dart';

/// Course card view
///
/// A reusable stateless widget to display a course card.
///
/// It takes a [title], [subtitle] and [path] to display the course details.
/// This widget can be reused for various course sections by providing different
/// titles, subtitles and paths.
class CourseCardText extends StatelessWidget {
  final String title;
  final String subtitle;
  final String identifier;
  final String semester;
  final String path;
  final bool live;

  const CourseCardText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.identifier,
    required this.semester,
    required this.path,
    required this.live,
  });

  static String _generateRandomLastStreamed() {
    final Random random = Random();
    List<String> options = [
      'Monday, 23/10/2023, 13:45',
      'NOW',
    ];
    final int randomIndex = random.nextInt(options.length);
    return options[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Add navigation to the course details screen
      },
      child: Card(
        elevation: 4, // Adjust the elevation for the shadow effect (if desired)
        shadowColor: Colors.black.withOpacity(0.5), // Shadow color and opacity
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Same radius as ClipRRect
          side: BorderSide(
            color: Colors.grey[100]!,
            width: 1.0,
          ), // Light grey outline
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Same radius as the Card
          child: Container(
            color: Colors.grey[50],
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCourseSubtitle(),
                    //_buildCourseIsLive(), //live or semester
                    _buildLive(),
                  ],
                ),
                _buildCourseTitle(),
                _buildLastLecture(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLastLecture() {
    return const Text("Last Lecture: Thursday, 26/10/2023, 10:00");
  }

  Widget _buildCourseTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      // Adjust the values as needed
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildCourseSubtitle() {
    return Text(
      subtitle,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildCourseIsLive() {
    return true //live
        ? Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(left: 4, right: 4),
            margin: EdgeInsets.only(bottom: 2),
            child: //spacing between dot and course number
                const Text(
              'Live',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          )
        : _buildCourseSemester(); // Return an empty SizedBox if not live
  }

  Widget _buildLive() {
    return true //live

        ? const Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: Colors.red,
              ),

              SizedBox(width: 5), // Add spacing between the dot and text
              Text(
                'Live Now',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        : _buildCourseSemester(); // Return an empty SizedBox if not live
  }

  Widget _buildCourseSemester() {
    return Text(
      semester,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildLastStreamed() {
    return Text(
      "lastStreamed",
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}
