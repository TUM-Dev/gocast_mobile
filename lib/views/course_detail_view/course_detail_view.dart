import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/course_detail_view/detail_course_content_view.dart';
import 'package:gocast_mobile/views/course_detail_view/stream_card.dart';

/// Course Detail View
///
/// A widget representing the 'streams of a course' section of the app.
/// It displays streams of a lecture and is accessible online
class CourseDetail extends ConsumerStatefulWidget {
  const CourseDetail({super.key});

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  late Future<List<Stream>> courseStreams;

  @override
  void initState() {
    super.initState();
    final userViewModelNotifier = ref.read(userViewModelProvider.notifier);

    Future.microtask(() {
      userViewModelNotifier.fetchCourseStreams(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseStreams = ref.watch(userViewModelProvider).courseStreams ?? [];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userViewModelProvider.notifier).fetchUserPinned();
        },
        child: courseStreams.isNotEmpty
            ? DetailCoursesContentView(
                title: "Course",
                streamCards: courseStreams
                    .map(
                      (stream) => StreamCard(
                        imageName: 'assets/images/course1.png',
                        // Replace with your image path
                        stream: stream,
                        onTap: () {
                          // Define your onTap functionality here
                        },
                      ),
                    )
                    .toList(), // Convert the iterable to a list
              )
            : Center(child: Text('No courses available')),
      ),
    );
  }
}
/*
class CourseDetail extends ConsumerWidget {
  const CourseDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContentView(
      title: 'Lineare Algebra für Informatik [MA0901]',
      videoCards: [
        VideoCard(
          imageName: 'assets/images/course1.png',
          title: 'complex numbers',
          date: 'July 24, 2019',
          duration: '02:00:00',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VideoPlayerCard(
                  videoUrl: "assets/reviewTrailer.mp4",
                  title: "title",
                  date: "date",
                ),
              ),
            );
          },
        ),
        // Add more VideoCard widgets as needed
      ],
    );
  }
}

 */

/*

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: courseStreams.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Center(child: Text('Entry')),
        );
      },
    );

     */
