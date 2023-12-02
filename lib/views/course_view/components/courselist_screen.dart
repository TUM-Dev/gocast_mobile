import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/base_view.dart';

/// CourseListScreen
///
/// This screen displays a list of courses.
///
/// It takes a [title] to display the title of the section and
/// dynamically generates a horizontal list of courses.
class CourseListScreen extends ConsumerWidget {
  final String title;
  final List<Widget> videoCards;

  const CourseListScreen({
    super.key,
    required this.title,
    required this.videoCards,
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
      child: ListView.builder(
        itemCount: videoCards.length,
        itemBuilder: (BuildContext context, int index) {
          return videoCards[index];
        },
      ),
    );
  }
}
