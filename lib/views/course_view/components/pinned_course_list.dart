import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/pinned_course_card.dart';

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
  final Future<void> Function()? onRefresh;

  const PinnedCourseList({
    super.key,
    required this.title,
    required this.pinnedCoursesCard,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
      title: title,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Implement search functionality
          },
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // Implement more options functionality
          },
        ),
      ],
      child: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollEndNotification && scrollInfo.metrics.extentBefore == 0.0) {
            onRefresh?.call();
          }
          return false;
        },
        child: Container(
          color: Colors.transparent,
          child: ListView.builder(
            itemCount: pinnedCoursesCard.isEmpty ? 1 : pinnedCoursesCard.length,
            itemBuilder: (BuildContext context, int index) {
              if (pinnedCoursesCard.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'No pinned courses',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return pinnedCoursesCard[index];
              }
            },
          ),
        ),
      ),
    );
  }
}