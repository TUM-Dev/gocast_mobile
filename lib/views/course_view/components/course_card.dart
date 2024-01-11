import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';

/// Course card view
///
/// A reusable stateless widget to display a course card.
///
/// It takes a [title], [tumID] and [path] to display the course details.
/// This widget can be reused for various course sections by providing different
/// titles, subtitles and paths.
class CourseCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String tumID;
  final String path;
  final bool live;
  final int courseId;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.tumID,
    required this.path,
    required this.live,
    required this.courseId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = subtitle == null
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.9;
    ThemeData themeData = Theme.of(context);
    if (MediaQuery.of(context).size.width >= 600) {
      cardWidth = subtitle == null
          ? MediaQuery.of(context).size.width * 0.2
          : MediaQuery.of(context).size.width * 0.4; //TODO test
    }
    return InkWell(
      onTap: onTap ??
          () {
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
        color: themeData.cardTheme.color,
        // Use card color from theme
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
            color: subtitle == null
                ? themeData.cardColor
                : themeData.cardTheme.color, // Apply card color from theme
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCourseTumID(),
                    _buildCourseIsLive(),
                  ],
                ),
                subtitle == null
                    ? Expanded(child: _buildCourseImage())
                    : const SizedBox(),
                _buildCourseTitle(themeData.textTheme),
                subtitle != null
                    ? _buildCourseSubtitle(themeData.textTheme)
                    : const SizedBox(),
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

  Widget _buildCourseTumID() {
    return Text(
      tumID,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
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
          ) ??
          const TextStyle(),
    );
  }

  Widget _buildCourseSubtitle(TextTheme textTheme) {
    return Text(
      subtitle!, //nullcheck already passed
      overflow: TextOverflow.ellipsis,
      style: textTheme.labelSmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1,
          ) ??
          const TextStyle(),
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
