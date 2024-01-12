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
  bool isNewestFirst = false;
  String selectedSemester = 'All';

  void filterCoursesBySemester(String selectedSemester) {
    List<Course> pinnedCourses =
        ref.read(userViewModelProvider).userPinned ?? [];
    if (selectedSemester == 'All') {
      setState(() {
        searchCourses = pinnedCourses;
      });
    } else {
      var parts =
          selectedSemester.split(' - '); // Assuming the format is "year - term"
      var year = int.parse(parts[0]);
      var term = parts[1];

      setState(() {
        searchCourses = pinnedCourses.where((course) {
          return course.semester.year == year &&
              course.semester.teachingTerm == term;
        }).toList();
      });
    }
  }

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
        sortCourses();
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

  void sortCourses() {
    List<Course> pinnedCourses =
        ref.read(userViewModelProvider).userPinned ?? [];

    pinnedCourses.sort((a, b) {
      // Compare by year first
      int yearComparison = a.semester.year.compareTo(b.semester.year);
      if (yearComparison != 0) {
        // If 'isNewestFirst' is true, reverse the year comparison
        return isNewestFirst ? -yearComparison : yearComparison;
      }

      // If years are equal, 'W' (Winter) should be considered more recent than 'S' (Summer)
      if (a.semester.teachingTerm == b.semester.teachingTerm) {
        return 0;
      }
      int termComparison = a.semester.teachingTerm == 'W' ? -1 : 1;

      // Reverse the term comparison if 'isNewestFirst' is true
      return isNewestFirst ? -termComparison : termComparison;
    });

    setState(() {
      searchCourses = pinnedCourses;
    });
  }

  List<String> convertAndSortSemesters(List<Semester> semesters,
      bool isNewestFirst,) {
    // Clone the list to avoid modifying the original
    List<Semester> sortedSemesters = List<Semester>.from(semesters);

    sortedSemesters.sort((a, b) {
      // Compare by year first
      int yearComparison = a.year.compareTo(b.year);
      if (yearComparison != 0) {
        // If 'isNewestFirst' is true, reverse the year comparison
        return isNewestFirst ? -yearComparison : yearComparison;
      }

      // If years are equal, 'W' (Winter) should be considered more recent than 'S' (Summer)
      if (a.teachingTerm == b.teachingTerm) {
        return 0;
      }
      int termComparison = a.teachingTerm == 'W' ? -1 : 1;

      // Reverse the term comparison if 'isNewestFirst' is true
      return isNewestFirst ? -termComparison : termComparison;
    });

    // Convert sorted semesters to string format "year - teachingTerm"
    return sortedSemesters
        .map((semester) => "${semester.year} - ${semester.teachingTerm}")
        .toList();
  }

  void _handleSortOptionSelected(String choice) {
    setState(() {
      isNewestFirst = (choice == 'Newest First');
      sortCourses(); // Call sortStreams to reorder the streams based on the new setting
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userPinned = ref.watch(userViewModelProvider).userPinned ?? [];
    final semesters = ref.watch(userViewModelProvider).semesters ?? [];
    return Scaffold(
      appBar: CustomSearchTopNavBar(
        searchController: searchController,
        onSortOptionSelected: _handleSortOptionSelected,
        title: "Pinned Courses",
        filterOptions: const ['Newest First', 'Oldest First', 'Semester'],
        onSemesterSelected: filterCoursesBySemester,
        semesters: convertAndSortSemesters(semesters, true),
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
