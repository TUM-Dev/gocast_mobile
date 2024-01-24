import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/base_view.dart';

import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_card.dart';

import '../../../utils/constants.dart';

/// CourseListScreen
///
/// This screen displays a list of courses.
///
/// It takes a [title] to display the title of the section and
/// dynamically generates a horizontal list of courses.
class DownloadCoursesContentView extends ConsumerWidget {
  final List<VideoCard> videoCards;

  const DownloadCoursesContentView({
    super.key,
    required this.videoCards,
  });

  //TODO implement filter and search functions in download view

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ;
    return BaseView(
        child: ListView.builder(
          itemCount: videoCards.isEmpty ? 1 : videoCards.length,
          itemBuilder: (BuildContext context, int index) {
            if (videoCards.isEmpty) {
              return const Center(
                child: Padding(
                  padding: AppPadding.sectionPadding,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 295.0),
                      child: Text('No Downloaded Courses'),
                    ),
                  ),
                ),
              );
            } else {
              return videoCards[index];
            }
          },
        ),
    );
  }
}
