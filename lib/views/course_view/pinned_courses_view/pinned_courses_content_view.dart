import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/base_view.dart';

import 'package:gocast_mobile/views/course_view/components/base_card.dart';

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
  final List<BaseCard> pinnedCourseCards;

  const PinnedCoursesContentView({
    super.key,
    required this.title,
    required this.pinnedCourseCards,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return BaseView(
      child: ListView.builder(
        itemCount: pinnedCourseCards.isEmpty ? 1 : pinnedCourseCards.length,
        itemBuilder: (BuildContext context, int index) {
          if (pinnedCourseCards.isEmpty) {
            return const Center(
              child: Padding(
                padding: AppPadding.sectionPadding,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 295.0),
                    child: Text('No Pinned Courses'),
                  ),
                ),
              ),
            );
          } else {
            return pinnedCourseCards[index];
          }
        },
      ),
    );
  }
}
