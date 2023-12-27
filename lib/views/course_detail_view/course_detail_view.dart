import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/course_detail_view/stream_card.dart';

import '../components/custom_search_top_nav_bar.dart';

/// Course Detail View
///
/// A widget representing the 'streams of a course' section of the app.
/// It displays streams of a lecture and is accessible online

class CourseDetail extends ConsumerStatefulWidget {
  final String title;
  final courseId;

  const CourseDetail({super.key, required this.title, required this.courseId});

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  late Future<List<Stream>> courseStreams;
  late List<String> thumbnails;
  final TextEditingController searchController = TextEditingController();
  final String baseUrl = 'https://live.rbg.tum.de';

  @override
  void initState() {
    super.initState();
    final videoViewModelNotifier = ref.read(videoViewModelProvider.notifier);

    Future.microtask(() async {
      await videoViewModelNotifier.fetchCourseStreams(widget.courseId);
      await videoViewModelNotifier.fetchThumbnails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseStreams = ref.watch(videoViewModelProvider).streams ?? [];
    final thumbnails = ref.watch(videoViewModelProvider).thumbnails ?? [];

    return Scaffold(
      appBar: CustomSearchTopNavBar(
        searchController: searchController,
        title: ' ',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userViewModelProvider.notifier).fetchUserPinned();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: courseStreams.isNotEmpty
                  ? ListView.builder(
                      itemCount: courseStreams.length,
                      itemBuilder: (context, index) {
                        final stream = courseStreams[index];
                        var thumbnail = thumbnails.length > index
                            ? thumbnails[index]
                            : '/thumb-fallback.png'; // Default thumbnail path
                        // Prepend base URL for relative paths
                        if (!thumbnail.startsWith('http')) {
                          thumbnail = '$baseUrl$thumbnail';
                        }

                        return StreamCard(
                          imageName: thumbnail, // Use corresponding thumbnail
                          stream: stream,
                          onTap: () {
                            // Define your onTap functionality here
                          },
                        );
                      },
                    )
                  : const Center(child: Text('No courses available')),
            ),
          ],
        ),
      ),
    );
  }
}


