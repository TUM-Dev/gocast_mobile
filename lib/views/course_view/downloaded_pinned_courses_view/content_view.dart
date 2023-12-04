import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/components/courselist_screen.dart';
import 'package:gocast_mobile/views/video_view/video_card_view.dart';

/// CourseContentScreen
///
/// A reusable widget that displays a list of video cards under a specific title.
/// This widget is designed to be flexible and can be used to represent various
/// types of course-related content, such as pinned courses or downloaded courses.
///
/// Parameters:
///   [title] - The title of the content section.
///   [videoCards] - A list of VideoCard widgets to be displayed under the title.
class CourseContentScreen extends ConsumerWidget {
  final String title;
  final List<VideoCard> videoCards;
  final Future<void> Function()? onRefresh;

  const CourseContentScreen({
    super.key,
    required this.title,
    required this.videoCards,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CourseListScreen(
      title: title,
      videoCards: videoCards,
      onRefresh: onRefresh,
    );
  }
}
