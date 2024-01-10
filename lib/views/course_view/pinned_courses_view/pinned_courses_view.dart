import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar.dart';
import 'package:gocast_mobile/views/course_view/pinned_courses_view/pinned_card.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';
import 'package:gocast_mobile/views/course_view/pinned_courses_view/pinned_courses_content_view.dart';
import 'package:gocast_mobile/views/video_view/video_player_controller.dart';

class PinnedCourses extends ConsumerStatefulWidget {
  const PinnedCourses({super.key});

  @override
  PinnedCoursesState createState() => PinnedCoursesState();
}

class PinnedCoursesState extends ConsumerState<PinnedCourses> {
  late List<Course> searchCourses;
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();

  Future<void> _refreshPinnedCourses() async {
    await ref.read(userViewModelProvider.notifier).fetchUserPinned();
  }

  @override
  void initState() {
    super.initState();
    _initializeCourses();
    searchController.addListener(_searchCourses);
  }

  void _initializeCourses() {
    final userViewModelNotifier = ref.read(userViewModelProvider.notifier);
    Future.microtask(() async {
      await userViewModelNotifier.fetchUserPinned();
      if (mounted) {
        setState(() {
          searchCourses = ref.read(userViewModelProvider).userPinned ?? [];
          isLoading = false; // Set isLoading to false here
        });
      }
    });
  }

  void _searchCourses() {
    final searchInput = searchController.text.toLowerCase();
    final userPinned = ref.watch(userViewModelProvider).userPinned ?? [];

    setState(() {
      if (searchInput.isEmpty) {
        searchCourses = userPinned;
      } else {
        searchCourses = userPinned.where((course) {
          return course.name.toLowerCase().contains(searchInput) ||
              course.slug.toLowerCase().contains(searchInput);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userPinned = ref.watch(userViewModelProvider).userPinned ?? [];
    return Scaffold(
      appBar: CustomSearchTopNavBar(
        searchController: searchController,
        title: "Pinned Courses",
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPinnedCourses,
        color: Colors.blue,
        backgroundColor: Colors.white,
        strokeWidth: 2.0,
        displacement: 20.0,
        child: PinnedCoursesContentView(
          title: "Pinned Courses",
          pinnedCourseCards: searchCourses.map((course) {
            final isPinned = searchCourses
                .any((pinnedCourse) => pinnedCourse.id == course.id);
            return PinnedCourseCard(
              imageName: 'assets/images/course2.png',
              course: course,
              onTap: () => _handleCourseTap(course, context),
              isPinned: isPinned,
              onPinToggle: () => _togglePin(course, isPinned),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _handleCourseTap(Course course, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetail(
          title: course.name,
          courseId: course.id,
        ),
      ),
    );
  }

  Future<void> _togglePin(Course course, bool isPinned) async {
    final viewModel = ref.read(userViewModelProvider.notifier);
    if (isPinned) {
      await viewModel.unpinCourse(course.id);
    } else {
      await viewModel.pinCourse(course.id);
    }
  }

  VideoSourceType determineSourceType(String videoSource) {
    return videoSource.startsWith('http')
        ? VideoSourceType.network
        : VideoSourceType.asset;
  }
}
