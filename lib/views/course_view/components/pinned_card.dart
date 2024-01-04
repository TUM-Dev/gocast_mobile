import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/course_view/components/big_card.dart';

class PinnedCourseCard extends BigCard {
  final Course course;
  final bool isPinned;
  final VoidCallback onPinToggle;

  const PinnedCourseCard({
    super.key,
    required super.imageName,
    required super.onTap,
    required this.course,
    required this.isPinned,
    required this.onPinToggle,
  });

  @override
  buildCardContent() {
    List<Widget> children = [];
    children.add(buildHeader('${course.name} - ${course.slug}',
        "${course.semester.year} ${course.semester.teachingTerm}"));
    children.add(buildImage());
    return children;
  }

  Widget _buildPinButton() {
    return IconButton(
      icon: Icon(
        isPinned ? Icons.push_pin : Icons.push_pin_outlined,
        color: Colors.blue[800],
      ),
      onPressed: onPinToggle,
    );
  }

  @override
  Widget buildHeader(String courseNameAndSlug, String courseDetails) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildInfo(courseNameAndSlug, courseDetails),
          _buildPinButton(),
        ],
      ),
    );
  }
}