import 'package:flutter/material.dart';

class LiveNowCard extends StatelessWidget {
  final String imageName;
  final String streamTitle;
  final String courseTitle;
  final String courseTumID;
  final VoidCallback onTap; // Add this line

  const LiveNowCard({
    super.key,
    required this.imageName,
    required this.streamTitle,
    required this.courseTitle,
    required this.courseTumID,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
            width: MediaQuery.of(context).size.width *
                0.4, // was 160, now it's 40% of the screen width
            padding: const EdgeInsets.all(8.0),
            color: Colors.white54,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStreamTitle(),
                    _buildCourseIsLive(),
                  ],
                ),
                Row(
                  children: [
                    _buildCourseTitle(),
                    const SizedBox(width: 5),
                    _buildCourseTumID(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCourseTitle() {
    return Text(
      courseTitle,
      maxLines: 2,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        height: 1,
        fontSize: 14.0,
      ),
    );
  }

  Widget _buildStreamTitle() {
    return Text(
      streamTitle,
      maxLines: 2,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        height: 1,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCourseTumID() {
    return Text(
      "($courseTumID)",
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 14.0,
      ),
    );
  }

  Widget _buildCourseIsLive() {
    return const Row(
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
    );
  }
}
