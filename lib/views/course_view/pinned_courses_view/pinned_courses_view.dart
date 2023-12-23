import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/course_view/components/pinned_course_card.dart';
import 'package:gocast_mobile/views/course_view/pinned_courses_view/pinned_courses_content_view.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';
import 'package:gocast_mobile/views/video_view/video_player_controller.dart';

class PinnedCourses extends ConsumerStatefulWidget {
  const PinnedCourses({super.key});

  @override
  PinnedCoursesState createState() => PinnedCoursesState();
}

class PinnedCoursesState extends ConsumerState<PinnedCourses> {
  // Define the refresh method here
  Future<void> _refreshPinnedCourses() async {
    await ref.read(userViewModelProvider.notifier).fetchUserPinned();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(userViewModelProvider.notifier).fetchUserPinned(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPinned = ref.watch(userViewModelProvider).userPinned ?? [];
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return RefreshIndicator(
      onRefresh: _refreshPinnedCourses,
      child: PinnedCoursesContentView(
        title: "Pinned Courses",
        pinnedCourseCards: userPinned.map((course) {
          final isPinned =
              userPinned.any((pinnedCourse) => pinnedCourse.id == course.id);
          return PinnedCourseCard(
            imageName: 'assets/images/course2.png',
            course: course,
            onTap: () async {
              try {
                await ref
                    .read(videoViewModelProvider.notifier)
                    .fetchCourseStreams(course.id);
                if (!mounted) {
                  return; // Check if the widget is still in the tree
                }
                var stream =
                    ref.read(videoViewModelProvider).streams?.firstOrNull;
                if (stream != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerPage(
                        videoSource: stream.playlistUrl,
                        title: course.name,
                        sourceType: determineSourceType(stream.playlistUrl),
                      ),
                    ),
                  );
                } else {
                  if (!mounted) return;
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content:
                          Text("No video stream available for this course."),
                    ),
                  );
                }
              } catch (e) {
                if (!mounted) return;
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text("Failed to load course streams: $e"),
                  ),
                );
              }
            },
            isPinned: isPinned,
            onPinToggle: () async {
              final viewModel = ref.read(userViewModelProvider.notifier);
              if (isPinned) {
                await viewModel.unpinCourse(course.id);
              } else {
                await viewModel.pinCourse(course.id);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  VideoSourceType determineSourceType(String videoSource) {
    // Logic to determine if the source is an asset or a network source
    return videoSource.startsWith('http')
        ? VideoSourceType.network
        : VideoSourceType.asset;
  }
}
