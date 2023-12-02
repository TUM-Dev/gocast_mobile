import 'package:flutter/material.dart';

/// VideoCard
///
/// A reusable widget that displays a video card with a thumbnail, title and subtitle.
/// This widget is designed to be flexible and can be used to represent various
/// types of video-related content, such as pinned videos or downloaded videos.
///
/// Parameters:
///  [imageName] - The name of the image to be displayed as the thumbnail.
///  [title] - The title of the video.
///  [date] - The date of the video.
///  [duration] - The duration of the video.
class VideoCard extends StatelessWidget {
  final String imageName;
  final String title;
  final String date;
  final String duration;

  const VideoCard({
    super.key,
    required this.imageName,
    required this.title,
    required this.date,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageName), // Replace with actual image paths
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(date),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Chip(
                    label: Text(duration),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
