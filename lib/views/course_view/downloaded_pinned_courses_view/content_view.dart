import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/components/courselist_screen.dart';

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
  final List<Widget> videoCards;

  const CourseContentScreen({
    super.key,
    required this.title,
    required this.videoCards,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CourseListScreen(
      title: title,
      videoCards: videoCards,
    );
  }
}
