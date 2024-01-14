import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/components/view_all_button.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final String? roomName;
  final String? roomNumber;
  final String? viewerCount;
  final String path;
  final bool live;
  final int courseId;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.tumID,
    this.roomName,
    this.roomNumber,
    this.viewerCount,
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
        elevation: 1,
        shadowColor: themeData.shadowColor.withOpacity(0.5),
        color: themeData.cardTheme.color,
        // Use card color from theme
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: themeData
                .inputDecorationTheme.enabledBorder!.borderSide.color
                .withOpacity(0.1), //TODO add check alternatives
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: cardWidth,
            padding: const EdgeInsets.all(8.0),
            color: subtitle != null
                ? themeData.cardColor
                : themeData.cardTheme.color, // Apply card color from theme
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCourseTumID(),
                    _buildCourseViewerCount(themeData),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Expanded(child: _buildCourseImage()),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          _buildCourseTitle(themeData.textTheme),
                          _buildCourseSubtitle(themeData.textTheme),
                          const SizedBox(height: 15),
                          _buildLocation(),
                          //_buildCourseIsLive(),
                        ],
                      ),
                    ),
                  ],
                ),
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
          aspectRatio: 16 / 12, //TODO how are the thumbnails given?
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            ),
          ),
        ),
        /*Positioned(
          bottom: 3, // Adjust this value based on your layout
          right: 3, // Adjust this value based on your layout
          child: _buildCourseViewerCount(),
        ),*/
      ],
    );
  }

  Widget _buildLocation() {
    final Uri url = Uri.parse('https://nav.tum.de/room/$roomNumber');

    return InkWell(
      onTap: () async {
        await launchUrl(url);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.room,
            size: 20, 
          ),
          Text(roomName!),
          //const SizedBox(width: 2),
          Transform.scale(
            scale: 0.6, // Adjust the scale factor as needed
            child: ViewAllButton(onViewAll: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseTumID() {
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

  Widget _buildCourseTitle(TextTheme textTheme) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2, //TODO check that this never causes overflow
      softWrap: true,
      style: textTheme.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1,
          ) ??
          const TextStyle(),
    );
  }

  Widget _buildCourseSubtitle(TextTheme textTheme) {
    return Text(
      subtitle!, //nullcheck already passed
      overflow: TextOverflow.ellipsis,
      //maxLines: 2,
      style: textTheme.labelSmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1,
          ) ??
          const TextStyle(),
    );
  }

  Widget _buildCourseViewerCount(ThemeData themeData) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.shadowColor.withOpacity(0.2), //Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(3),
      child: //spacing between dot and course number
          Text(
        "${viewerCount!} viewers",
        style: themeData.textTheme.labelSmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1,
            ) ??
            const TextStyle(),
      ),
    ); // Return an empty SizedBox if not live
  }
}
