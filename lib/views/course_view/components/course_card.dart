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
    double cardWidth = MediaQuery.of(context).size.width * 0.4;

    if (MediaQuery.of(context).size.shortestSide >= 600) {
      cardWidth = MediaQuery.of(context).size.width * 0.2;
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
        elevation: 2, // Adjust the elevation for the shadow effect (if desired)
        shadowColor: Colors.grey.withOpacity(0.5), // Shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Same radius as ClipRRect
          side: BorderSide(
            color: Colors.grey[100] ?? Colors.grey,
            width: 1.0,
          ), // Light grey outline
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Same radius as the Card
          child: Container(
            width: cardWidth, // was 160, now it's 40% of the screen width
            padding: const EdgeInsets.all(8.0),
            color: Colors.white70,
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
                _buildCourseTitle(),
                subtitle != null ? _buildCourseSubtitle() : const SizedBox(),
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

  Widget _buildCourseTitle() {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      softWrap: true,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1,
      ),
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

  Widget _buildCourseSubtitle() {
    return Text(
      subtitle!, //nullcheck already passed
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
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
