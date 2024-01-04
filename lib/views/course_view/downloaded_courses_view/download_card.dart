import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String imageName;
  final String title;
  final String date;
  final String duration;
  final VoidCallback onTap;

  const VideoCard({
    super.key,
    required this.imageName,
    required this.title,
    required this.date,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildVideoInfo(title, date),
            _buildImage(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo(String title, String date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
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
          Text(
            date,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.asset(
          imageName,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
