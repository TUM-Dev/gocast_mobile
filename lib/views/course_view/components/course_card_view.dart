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
      },
      child: Card(
        elevation: 2, // Adjust the elevation for the shadow effect (if desired)
        shadowColor: Colors.grey.withOpacity(0.5), // Shadow
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
            width: MediaQuery.of(context).size.width *
                0.4, // was 160, now it's 40% of the screen width
            padding: const EdgeInsets.all(8.0),
            color: Colors.white70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCourseSubtitle(),
                    _buildLive(),
                  ],
                ),
                Expanded(child: _buildCourseImage()), // Wrapped with Expanded
                _buildCourseTitle(),
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
        Stack(
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
            /*Positioned(
              bottom: 2, // Adjust as needed for the position
              left: 2, // Adjust as needed for the position
              child: _buildLive(), // Place the _buildLive widget here
            ),*/
          ],
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

  Widget _buildLive() {
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
