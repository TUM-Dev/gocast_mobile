import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/components/pinned_course_card.dart';
import 'package:gocast_mobile/views/course_view/pinned_courses_view/pinned_courses_base_view.dart';
import 'package:gocast_mobile/utils/constants.dart';

/// PinnedCourseList
///
/// This screen displays a list of pinned courses.
///
/// Parameters:
///   [title] - The title of the screen.
///   [pinnedCoursesCard] - A list of cards representing pinned courses.
///
class PinnedCourseList extends ConsumerWidget {
  final String title;
  final List<PinnedCourseCard> pinnedCoursesCard;

  const PinnedCourseList({
    super.key,
    required this.title,
    required this.pinnedCoursesCard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController searchController = TextEditingController();

    return PinnedCoursesBaseView(
      searchController: searchController,
      child: ListView.builder(
        itemCount: pinnedCoursesCard.isEmpty ? 1 : pinnedCoursesCard.length,
        itemBuilder: (BuildContext context, int index) {
          if (pinnedCoursesCard.isEmpty) {
            return const Center(
              child: _noCourseInfoText,
            );
          } else {
            return pinnedCoursesCard[index];
          }
        },
      ),
    );
  }
}

const Widget _noCourseInfoText = Padding(
  padding: AppPadding.sectionPadding,
  child: Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 295.0),
      child: Text('No Pinned Courses'),
    ),
  ),
);
