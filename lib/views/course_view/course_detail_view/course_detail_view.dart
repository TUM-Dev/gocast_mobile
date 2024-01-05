import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar_back_button.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/stream_card.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';

class CourseDetail extends ConsumerStatefulWidget {
  final String title;
  final int courseId;

  const CourseDetail({super.key, required this.title, required this.courseId});

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

  /// Displays the course title.
  Widget _courseTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
    return Expanded(
      child: courseStreams.isNotEmpty
          ? ListView.builder(
        itemCount: courseStreams.length,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemBuilder: (context, index) => _streamCardBuilder(
                context,
                index,
                courseStreams,
                thumbnails,
                scaffoldMessenger,
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
    var thumbnail = _getThumbnailUrl(index, thumbnails);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StreamCard(
        imageName: thumbnail,
        stream: stream,
        onTap: () => _handleStreamTap(context, scaffoldMessenger, stream),
      ),
    );
  }

  /// Determines the thumbnail URL for a stream.
  String _getThumbnailUrl(int index, List<String> thumbnails) {
    var thumbnail = thumbnails.length > index
        ? thumbnails[index]
        : '/thumb-fallback.png'; // Default thumbnail path
    if (!thumbnail.startsWith('http')) {
      thumbnail = '$baseUrl$thumbnail';
    }
    return thumbnail;
  }

  /// Handles taps on stream cards.
  Future<void> _handleStreamTap(
    BuildContext context,
    ScaffoldMessengerState scaffoldMessenger,
    Stream stream,
  ) async {
    try {
      await _navigateToVideoPlayer(ref, context, stream);
    } catch (e) {
      _showErrorSnackBar(
        scaffoldMessenger,
        "Failed to load course streams: $e",
      );
    }
  }

  /// Navigates to the video player page.
  Future<void> _navigateToVideoPlayer(
    WidgetRef ref,
    BuildContext context,
    Stream clickedStream,
  ) async {
    // Fetch course streams only if not already fetched
    final streams = ref.read(videoViewModelProvider).streams;
    if (streams == null || streams.isEmpty) {
      await ref
          .read(videoViewModelProvider.notifier)
          .fetchCourseStreams(widget.courseId);
      if (!mounted) return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerPage(
          stream: clickedStream,
        ),
      ),
    );
  }

  /// Shows an error snackbar.
  void _showErrorSnackBar(
    ScaffoldMessengerState scaffoldMessenger,
    String message,
  ) {
    if (!mounted) return;
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}