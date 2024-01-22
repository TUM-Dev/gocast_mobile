import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar_back_button.dart';
import 'package:gocast_mobile/views/course_view/components/pin_button.dart';
import 'package:gocast_mobile/views/course_view/components/stream_card.dart';

class CourseDetail extends ConsumerStatefulWidget {
  final String title;
  final int courseId;
  final String? courseTumId;

  const CourseDetail({
    super.key,
    required this.title,
    required this.courseId,
    this.courseTumId,
  });

  @override
  CourseDetailState createState() => CourseDetailState();
}

class CourseDetailState extends ConsumerState<CourseDetail> {
  late Future<List<Stream>> courseStreams;
  late List<String> thumbnails;
  final TextEditingController searchController = TextEditingController();
  final String baseUrl = 'https://live.rbg.tum.de';

  @override
  void initState() {
    super.initState();
    _initializeStreams();
  }

  void _initializeStreams() {
    final videoViewModelNotifier = ref.read(videoViewModelProvider.notifier);
    Future.microtask(() async {
      await videoViewModelNotifier.fetchCourseStreams(widget.courseId);
      await videoViewModelNotifier.fetchThumbnails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final courseStreams = ref.watch(videoViewModelProvider).streams ?? [];
    final thumbnails = ref.watch(videoViewModelProvider).thumbnails ?? [];

    return Scaffold(
      appBar: CustomSearchTopNavBarWithBackButton(
        searchController: searchController,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshPinnedUser(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _courseTitle(widget.title),
            _buildStreamList(
              context,
              courseStreams,
              thumbnails,
              scaffoldMessenger,
            ),
          ],
        ),
      ),
    );
  }

  /// Fetches user pinned information.
  Future<void> _refreshPinnedUser() async {
    await ref.read(userViewModelProvider.notifier).fetchUserPinned();
  }

  // In _courseTitle method of CourseDetailState
  Widget _courseTitle(String title) {
    bool isPinned = _checkPinStatus();

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          PinButton(
            courseId: widget.courseId,
            isInitiallyPinned: isPinned,
            onPinStatusChanged: () => setState(() {}),
          ),
        ],
      ),
    );
  }

  /// Builds the list of streams.
  Widget _buildStreamList(
    BuildContext context,
    List<Stream> courseStreams,
    List<String> thumbnails,
    ScaffoldMessengerState scaffoldMessenger,
  ) {
    double width = MediaQuery.of(context).size.width;
    bool isTablet = width >= 600 ? true : false;
    return Expanded(
      child: courseStreams.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? width * 0.15 : 0),
              child: ListView.builder(
                itemCount: courseStreams.length,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (context, index) => _streamCardBuilder(
                  context,
                  index,
                  courseStreams,
                  thumbnails,
                  scaffoldMessenger,
                ),
              ),
            )
          : const Center(child: Text('No courses available')),
    );
  }

  /// Builds individual stream cards.
  Widget _streamCardBuilder(
    BuildContext context,
    int index,
    List<Stream> courseStreams,
    List<String> thumbnails,
    ScaffoldMessengerState scaffoldMessenger,
  ) {
    final stream = courseStreams[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StreamCard(stream: stream),
    );
  }

  bool _checkPinStatus() {
    final userPinned = ref.watch(userViewModelProvider).userPinned ?? [];
    // Iterate over the userPinned list and check if courseId matches
    for (var course in userPinned) {
      if (course.id == widget.courseId) {
        return true; // Course is pinned
      }
    }
    return false; // Course is not pinned
  }
}
