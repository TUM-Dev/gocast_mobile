import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/course_view/components/base_card.dart';

class StreamCard extends BaseCard {
  final Stream stream;

  const StreamCard({
    super.key,
    required super.imageName,
    required this.stream,
    required super.onTap,
  });

  @override
  List<Widget> buildCardContent() {
    return [
      buildHeader(
        title: stream.name,
        subtitle: stream.description,
      ),
      buildInternetImage(),
    ];
  }
}

