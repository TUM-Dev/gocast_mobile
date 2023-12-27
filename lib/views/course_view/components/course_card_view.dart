import 'package:flutter/material.dart';

import '../../course_detail_view/course_detail_view.dart';

/// Course card view
///
/// A reusable stateless widget to display a course card.
///
/// It takes a [title], [subtitle] and [path] to display the course details.
/// This widget can be reused for various course sections by providing different
/// titles, subtitles and paths.
class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String path;
  final bool live;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.path,
    required this.live,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Add navigation to the course details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CourseDetail(title: title), // Navigating to CourseDetail
          ),
        );
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.4, // was 160, now it's 40% of the screen width
          padding: const EdgeInsets.all(8.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildCourseImage()), // Wrapped with Expanded
              _buildCourseTitle(),
              _buildCourseSubtitle(),
              _buildCourseIsLive(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseImage() {
    return AspectRatio(
      aspectRatio: 10 / 7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCourseTitle() {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
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
    return live
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
        : const SizedBox(); // Return an empty SizedBox if not live
  }
}
