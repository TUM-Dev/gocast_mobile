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
    required int courseId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Add navigation to the course details screen
      },
      child: Card(
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Same radius as ClipRRect
          side: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Same radius as the Card
          child: Container(
            color: Colors.white, //Colors.blue.withOpacity(0.01), //Colors.grey[50],
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildCourseImage(),
                const SizedBox(width: 10),
                Expanded(
                  //to prevent title overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCourseSubtitle(),
                      _buildCourseTitle(),
                      _buildLastLecture(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseImage() {
    return ClipOval(
      child: Image.asset(
        path,
        fit: BoxFit.cover,
        width: 50, // set your desired width
        height: 50, // set your desired height
      ),
    );
  }

  Widget _buildLastLecture() {
    //return const Text("Last Lecture: Thursday, 26/10/2023, 10:00");
    return Text(
      'Last Lecture: Thursday, 26/10/2023, 10:00',
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12.0,
      ),
    );
  }

  Widget _buildCourseTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 2),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(
          fontSize: 16, //17,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          height: 0.9,
        ),
      ),
    );
  }

  Widget _buildCourseSubtitle() {
    return Text(
      subtitle,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
        height: 0.9,
      ),
    );
  }

  Widget _buildCourseIsLive() {
    return false //live
        ? Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(left: 4, right: 4),
            margin: const EdgeInsets.only(bottom: 2),
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

  Widget _buildTumIDColor() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.only(left: 4, right: 4),
      margin: const EdgeInsets.only(bottom: 2),
      child: //spacing between dot and course number
          Text(
        subtitle,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildLive() {
    return false //live
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
    return const Text(
      "lastStreamed",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}
