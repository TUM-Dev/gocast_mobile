import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

enum CardType { pinnedCourse, video, stream }

class BigCard extends StatelessWidget {
  final String imageName;
  final String? title;
  final String? date;
  final String? duration;
  final Course? course;
  final Stream? stream;
  final bool? isPinned;
  final VoidCallback? onPinToggle;
  final VoidCallback onTap;
  final CardType cardType;

  BigCard({
    super.key,
    required this.cardType,
    required this.imageName,
    this.title,
    this.date,
    this.duration,
    this.course,
    this.stream,
    this.isPinned,
    this.onPinToggle,
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
            if (cardType == CardType.pinnedCourse)
              _buildHeader('${course?.name} - ${course?.slug}',
                  "${course?.semester.year} ${course?.semester.teachingTerm}"),
            if (cardType == CardType.video) _buildHeader(title!, date!),
            if (cardType == CardType.stream)
              _buildHeader(stream!.name, stream!.description),
            cardType == CardType.stream ? _buildInternetImage() : _buildImage(),
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String courseNameAndSlug, String courseDetails) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfo(courseNameAndSlug, courseDetails),
          if (cardType == CardType.pinnedCourse) _buildPinButton(),
        ],
      ),
    );
  }

  Widget _buildInfo(String courseNameAndSlug, String courseDetails) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseNameAndSlug,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
          const SizedBox(height: 8.0),
          Text(
            courseDetails,
            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPinButton() {
    return IconButton(
      icon: Icon(
        isPinned ?? false ? Icons.push_pin : Icons.push_pin_outlined,
        color: Colors.blue[800],
      ),
      onPressed: onPinToggle,
    );
  }

  Widget _buildInternetImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        imageName,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/default_image.png',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.asset(
        imageName,
        fit: BoxFit.cover,
      ),
    );
  }
}
