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
  final String tumID;
  final String identifier;
  final String semester;
  final String path;
  final bool live;

  const CourseCardText({
    super.key,
    required this.title,
    required this.tumID,
    required this.identifier,
    required this.semester,
    required this.path,
    required this.live,
    required int courseId,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return InkWell(
      onTap: () {
        // TODO: Add navigation to the course details screen
      },
      child: Card(
        elevation: 1,
        surfaceTintColor: themeData.cardColor,
        shadowColor: Colors.grey.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Same radius as ClipRRect
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Same radius as the Card
            child: Row(
              children: [
                Container(
                  width: 5,
                  height: 60,
                  color: Colors.blue,
                ),
                Container(
                  color: themeData.cardColor,
                  //Colors.blue.withOpacity(0.01), //Colors.grey[50],
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCourseSubtitle(),
                      _buildCourseTitle(themeData.textTheme),
                      _buildLastLecture(),
                    ],
                  ),
                ),
              ],
            ),),
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

  Widget _buildCourseImage2() {
    return ClipOval(
      child: Icon(
        Icons.school, //TODO rounder feel
        size: 50,
        color: Colors
            .blue.shade900, //iconTheme?.copyWith(color: Colors.blue.shade900),
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

  Widget _buildCourseTitle(TextTheme textTheme) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2, //TODO check that this never causes overflow
      softWrap: true,
      style: textTheme.titleMedium?.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1,
          ) ??
          const TextStyle(),
    );
  }

  Widget _buildCourseSubtitle() {
    return Text(
      tumID,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
        height: 0.9,
      ),
    );
  }
}
