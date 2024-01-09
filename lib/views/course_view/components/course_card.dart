import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';

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
  final int courseId;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.path,
    required this.live,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.4;
    ThemeData themeData = Theme.of(context);

    if (MediaQuery.of(context).size.shortestSide >= 600) {
      cardWidth = MediaQuery.of(context).size.width * 0.2;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetail(
              title: title,
              courseId: courseId,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shadowColor: themeData.shadowColor.withOpacity(0.5),
        color: themeData.cardTheme.color, // Use card color from theme
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: themeData.dividerColor,
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: cardWidth,
            padding: const EdgeInsets.all(8.0),
            color: themeData.cardColor, // Apply card color from theme
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCourseSubtitle(themeData.textTheme),
                    _buildCourseIsLive(),
                  ],
                ),
                Expanded(child: _buildCourseImage()),
                _buildCourseTitle(themeData.textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseImage() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 10 / 7,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseTitle(TextTheme textTheme) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      softWrap: true,
      style: textTheme.titleMedium?.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1,
      ) ?? const TextStyle(),
    );
  }

  Widget _buildCourseSubtitle(TextTheme textTheme) {
    return Text(
      subtitle,
      overflow: TextOverflow.ellipsis,
      style: textTheme.titleSmall ?? const TextStyle(),
    );
  }


  Widget _buildCourseIsLive() {
    return live
        ? Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: //spacing between dot and course number
                const Text(
              'Live',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        : const SizedBox(); // Return an empty SizedBox if not live
  }
}
