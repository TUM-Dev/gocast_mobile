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
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            child: Column(
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

  Widget _buildCourseImage() {
    return SizedBox(
      height: 80,
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imageName,
            fit: BoxFit.cover,
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
