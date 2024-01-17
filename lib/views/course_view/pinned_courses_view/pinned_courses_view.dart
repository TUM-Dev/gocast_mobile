import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/sort_utils.dart';
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
  late List<Course> displayedCourses = [];
  late List<Course> allPinnedCourses = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();
  late List<Course> temp;
  bool isSearchInitialized = false;

  Future<void> _refreshPinnedCourses() async {
    await ref.read(userViewModelProvider.notifier).fetchUserPinned();
    final selectedSemester =
        ref.read(userViewModelProvider).selectedSemester ?? 'All';
    if (mounted) {
      setState(() {
        allPinnedCourses = ref.watch(userViewModelProvider).userPinned ?? [];
        displayedCourses = allPinnedCourses;
        _handleSortOptionSelected(
            ref.read(userViewModelProvider).selectedFilterOption);
        filterCoursesBySemester(selectedSemester);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCourses();
    searchController.addListener(_searchCourses);
  }

  void _initializeCourses() {
    final userViewModelNotifier = ref.read(userViewModelProvider.notifier);
    final selectedSemester =
        ref.read(userViewModelProvider).selectedSemester ?? 'All';
    Future.microtask(() async {
      await userViewModelNotifier.fetchUserPinned();
      if (mounted) {
        setState(() {
          allPinnedCourses = ref.watch(userViewModelProvider).userPinned ?? [];
          displayedCourses = allPinnedCourses;
          _handleSortOptionSelected('Semester');
          filterCoursesBySemester(selectedSemester);
          isLoading = false; // Set isLoading to false here
        });
      }
    });
  }

  void filterCoursesBySemester(String selectedSemester) {
    setState(() {
      ref
          .read(userViewModelProvider.notifier)
          .updateSelectedSemester(selectedSemester);
      displayedCourses = CourseUtils.filterCoursesBySemester(
          allPinnedCourses, selectedSemester);
    });
  }


  void _handleSortOptionSelected(String choice) {
    setState(() {
      ref
          .read(userViewModelProvider.notifier)
          .updateSelectedFilterOption(choice);
      CourseUtils.sortCourses(
          displayedCourses,
          ref
              .read(userViewModelProvider)
              .selectedFilterOption); // Call sortStreams to reorder the streams based on the new setting
    });
  }

  void _searchCourses() {
    final searchInput = searchController.text.toLowerCase();
    if (!isSearchInitialized) {
      temp = List.from(displayedCourses);
      isSearchInitialized = true;
    }

    setState(() {
      if (searchInput.isEmpty) {
        displayedCourses = temp;
        isSearchInitialized = false;
      } else {
        displayedCourses = displayedCourses.where((course) {
          return course.name.toLowerCase().contains(searchInput) ||
              course.slug.toLowerCase().contains(searchInput);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSearchTopNavBar(
        searchController: searchController,
        onSortOptionSelected: _handleSortOptionSelected,
        title: "Pinned Courses",
        filterOptions: const ['Newest First', 'Oldest First', 'Semester'],
        onSemesterSelected: filterCoursesBySemester,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPinnedCourses,
        color: Colors.blue,
        backgroundColor: Colors.white,
        strokeWidth: 2.0,
        displacement: 20.0,
        child: PinnedCoursesContentView(
          title: "Pinned Courses",
          pinnedCourseCards: displayedCourses.map((course) {
            final isPinned = displayedCourses
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
    await _refreshPinnedCourses();
  }

  VideoSourceType determineSourceType(String videoSource) {
    return videoSource.startsWith('http')
        ? VideoSourceType.network
        : VideoSourceType.asset;
  }
}
