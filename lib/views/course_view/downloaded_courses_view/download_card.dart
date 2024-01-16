import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/course_view/components/base_card.dart';

class VideoCard extends BaseCard {
  final String title;
  final String date;
  final String duration;

  const VideoCard({
    super.key,
    required super.imageName,
    required this.title,
    required this.date,
    required this.duration,
    required super.onTap,
  });

  @override
  List<Widget> buildCardContent() {
    return [
      buildHeader(
        title: title,
        subtitle: date,
      ),
      buildImage(),
    ];
  }
}
