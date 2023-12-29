import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_card.dart';

/// CourseListScreen
///
/// This screen displays a list of courses.
///
/// It takes a [title] to display the title of the section and
/// dynamically generates a horizontal list of courses.
class DownloadCoursesContentView extends ConsumerWidget {
  final String title;
  final List<VideoCard> videoCards;
  final Future<void> Function()? onRefresh;

  const DownloadCoursesContentView({
    super.key,
    required this.title,
    required this.videoCards,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();

    return BaseView(
      customAppBar: CustomSearchTopNavBar(
        searchController: searchController,
        title: title,
      ),
      showLeading: false,
      child: RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        child: ListView.builder(
          itemCount: videoCards.length,
          itemBuilder: (BuildContext context, int index) {
            return videoCards[index];
          },
        ),
      ),
    );
  }
}
