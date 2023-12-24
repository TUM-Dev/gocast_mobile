import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/video_view/video_card_view.dart';

/// CourseListScreen
///
/// This screen displays a list of courses.
///
/// It takes a [title] to display the title of the section and
/// dynamically generates a horizontal list of courses.
class CourseListScreen extends ConsumerWidget {
  final String title;
  final List<VideoCard> videoCards;
  final Future<void> Function()? onRefresh;

  const CourseListScreen({
    super.key,
    required this.title,
    required this.videoCards,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
      showLeading: false,
      title: title,
      actions: [
        if (onRefresh != null)
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
          ),
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
      child: ListView.builder(
        itemCount: videoCards.length,
        itemBuilder: (BuildContext context, int index) {
          return videoCards[index];
        },
      ),
    );
  }
}
