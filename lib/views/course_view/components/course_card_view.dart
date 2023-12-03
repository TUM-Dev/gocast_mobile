import 'package:flutter/material.dart';

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

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Add navigation to the course details screen
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.4, // was 160, now it's 40% of the screen width
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCourseImage(),
              _buildCourseTitle(),
              _buildCourseSubtitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseImage() {
    return Expanded(
      child: Image.asset(
        path, // Replace with the actual path to your course image
        fit: BoxFit.cover,
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
      ), // Replace with the exact color
    );
  }
}
