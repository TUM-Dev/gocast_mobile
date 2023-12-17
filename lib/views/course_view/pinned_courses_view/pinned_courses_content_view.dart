import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/components/pinned_course_list.dart';
import 'package:gocast_mobile/views/course_view/components/pinned_course_card.dart';

/// PinnedCoursesContentView
///
/// A widget that presents a list of pinned course cards organized under a specific title.
/// This widget is versatile and can be employed to showcase different types of
/// course-related content, including pinned courses or downloaded courses.
///
/// Parameters:
///   [title] - The title of the content section.
///   [pinnedCourseCards] - A list of cards representing pinned courses.
///
class PinnedCoursesContentView extends ConsumerWidget {
  final String title;
  final List<PinnedCourseCard> pinnedCourseCards;
  final Future<void> Function()? onRefresh;

  const PinnedCoursesContentView({
    super.key,
    required this.title,
    required this.pinnedCourseCards,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PinnedCourseList(
      title: title,
      pinnedCoursesCard: pinnedCourseCards,
      onRefresh: onRefresh,
    );
  }
}
