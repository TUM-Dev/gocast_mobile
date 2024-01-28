import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar.dart';

import 'package:gocast_mobile/views/course_view/components/course_card.dart';

/// PinnedCoursesContentView
///
/// A widget that presents a list of pinned course cards organized under a specific title.
/// This widget is versatile and can be employed to showcase different types of
/// course-related content, including pinned courses or downloaded courses.
///
/// Parameters:
///   [pinnedCourseCards] - A list of cards representing pinned courses.
///
class PinnedCoursesContentView extends ConsumerWidget {
  final List<CourseCard> pinnedCourseCards;
  final CustomSearchTopNavBar customAppBar;

  const PinnedCoursesContentView({
    super.key,
    required this.pinnedCourseCards,
    required this.customAppBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;

    return BaseView(
      customAppBar: customAppBar,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                width >= 600 ? MediaQuery.of(context).size.width * 0.15 : 0,
          ),
          child: ListView.builder(
            itemCount: pinnedCourseCards.isEmpty ? 1 : pinnedCourseCards.length,
            itemBuilder: (BuildContext context, int index) {
              if (pinnedCourseCards.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: AppPadding.sectionPadding,
                    child: Center(
                      child: Padding(
                        padding: AppPadding.sectionPadding,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 295.0),
                            child: Text('No Pinned Courses'),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(bottom: width * 0.02),
                  child: pinnedCourseCards[index],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
