import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/course_view/components/base_card.dart';
import 'package:gocast_mobile/views/course_view/components/pin_button.dart';

class PinnedCourseCard extends BaseCard {
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
  List<Widget> buildCardContent() {
    return [
      buildHeader(
        title: '${course.name} - ${course.tUMOnlineIdentifier}',
        subtitle: "${course.semester.year} ${course.semester.teachingTerm}",
        trailing: PinButton(
          // Use PinButton
          courseId: course.id,
          isInitiallyPinned: isPinned,
          onPinStatusChanged: onPinToggle,
        ),
      ),
      buildImage(),
    ];
  }
}
