import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';

import 'package:gocast_mobile/views/components/custom_search_top_nav_bar_back_button.dart';
import 'package:gocast_mobile/views/course_view/components/pin_button.dart';
import 'package:gocast_mobile/views/course_view/components/stream_card.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';

import 'package:tuple/tuple.dart';

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
  late List<Tuple2<Stream, String>> temp;
  final TextEditingController searchController = TextEditingController();
  final String baseUrl = 'https://live.rbg.tum.de';
  bool isSearchInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeStreams();
    searchController.addListener(_searchCourses);
  }

  // set the thumbnails streams and search results
  void _initializeStreams() {
    final videoViewModelNotifier = ref.read(videoViewModelProvider.notifier);
    Future.microtask(() async {
      await videoViewModelNotifier.fetchCourseStreams(widget.courseId);
      await videoViewModelNotifier.fetchThumbnails();
    });
  }

  void _handleSortOptionSelected(String choice) {
    var allStreams = ref.watch(videoViewModelProvider).streamsWithThumb ?? [];
    ref
        .read(videoViewModelProvider.notifier)
        .updateSelectedFilterOption(choice, allStreams);
  }

  void _searchCourses() {
    final videoViewModelNotifier = ref.read(videoViewModelProvider.notifier);
    var displayedStreams =
        ref.watch(videoViewModelProvider).displayedStreams ?? [];
    final searchInput = searchController.text.toLowerCase();
    if (!isSearchInitialized) {
      temp = List.from(displayedStreams);
      isSearchInitialized = true;
    }

    setState(() {
      if (searchInput.isEmpty) {
        videoViewModelNotifier.updatedDisplayedStreams(temp);
        isSearchInitialized = false;
      } else {
        displayedStreams = displayedStreams.where((stream) {
          return stream.item1.name.toLowerCase().contains(searchInput) ||
              stream.item1.description.toLowerCase().contains(searchInput);
        }).toList();
        videoViewModelNotifier.updatedDisplayedStreams(displayedStreams);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final streams = ref.watch(videoViewModelProvider).displayedStreams ?? [];
    return Scaffold(
      appBar: CustomSearchTopNavBarWithBackButton(
        searchController: searchController,
        onClick: _handleSortOptionSelected,
        filterOptions: const ['Newest First', 'Oldest First'],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshStreams(widget.courseId),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _courseTitle(widget.title),
            _buildStreamList(
              context,
              streams,
              scaffoldMessenger,
            ),
          ],
        ),
      ),
    );
  }

  /// Fetches user pinned information.

  Future<void> _refreshStreams(int courseID) async {
    await ref
        .read(videoViewModelProvider.notifier)
        .fetchCourseStreams(courseID);
    await ref.read(videoViewModelProvider.notifier).fetchThumbnails();
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
    List<Tuple2<Stream, String>> streamsWithThumb,
    ScaffoldMessengerState scaffoldMessenger,
  ) {
    double width = MediaQuery.of(context).size.width;
    bool isTablet = width >= 600 ? true : false;
    return Expanded(
      child: streamsWithThumb.isNotEmpty
          ? Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: isTablet ? width * 0.15 : 0),
              child: ListView.builder(
                itemCount: streamsWithThumb.length,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (context, index) => _streamCardBuilder(
                  context,
                  index,
                  streamsWithThumb,
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
    List<Tuple2<Stream, String>> streamsWithThumb,
    ScaffoldMessengerState scaffoldMessenger,
  ) {
    final streamWithThumb = streamsWithThumb[index];
    final stream = streamWithThumb.item1;
    final thumbnail = _getThumbnailUrl(streamWithThumb.item2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StreamCard(
        imageName: thumbnail,
        stream: stream,
        onTap: () => _handleStreamTap(context, scaffoldMessenger, stream),
      ),
    );
  }

  String _getThumbnailUrl(String thumbnail) {
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

  bool _checkPinStatus() {
    final userPinned = ref.watch(pinnedCourseViewModelProvider).userPinned ?? [];
    // Iterate over the userPinned list and check if courseId matches
    for (var course in userPinned) {
      if (course.id == widget.courseId) {
        return true; // Course is pinned
      }
    }
    return false; // Course is not pinned
  }
}
