import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/course_view/components/base_card.dart';
class VideoCard extends BaseCard {
  final String title;
  final String date;
  final String duration;
  final VoidCallback onDelete;

  const VideoCard({
    super.key,
    required this.title,
    required this.date,
    required this.duration,
    required super.imageName,
    required super.onTap,
    required this.onDelete,
  });

  @override
  List<Widget> buildCardContent() {
    return [
      buildHeader(
        title: title,
        subtitle: date,
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
      buildImage(), // Assuming this method exists in BaseCard for displaying the image
      // Additional content can be added here if needed
    ];
  }
}
