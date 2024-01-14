import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/sort_utils.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar_back_button.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/courses_list_view.dart';

class MyCourses extends ConsumerStatefulWidget {
  const MyCourses({super.key});

  @override
  MyCoursesState createState() => MyCoursesState();
}

class MyCoursesState extends ConsumerState<MyCourses> {
  late List<Course> displayedUserCourses = [];
  late List<Course> allUserCourses = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();
  bool isNewestFirst = false;
  late List<Course> temp;
  bool isSearchInitialized = false;

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
          allUserCourses = ref.read(userViewModelProvider).userCourses ?? [];
          displayedUserCourses = allUserCourses;
          isLoading = false; // Set isLoading to false here
          _handleSortOptionSelected('Semester');
          filterCoursesBySemester(selectedSemester);
        });
      }
    });
  }

  void _handleSortOptionSelected(String choice) {
    setState(() {
      ref
          .read(userViewModelProvider.notifier)
          .updateSelectedFilterOption(choice);
      CourseUtils.sortCourses(
          displayedUserCourses,
          ref
              .read(userViewModelProvider)
              .selectedFilterOption); // Call sortStreams to reorder the streams based on the new setting
    });
  }

  void filterCoursesBySemester(String selectedSemester) {
    setState(() {
      ref
          .read(userViewModelProvider.notifier)
          .updateSelectedSemester(selectedSemester);
      displayedUserCourses =
          CourseUtils.filterCoursesBySemester(allUserCourses, selectedSemester);
    });
  }

  void _searchCourses() {
    final searchInput = searchController.text.toLowerCase();
    if (!isSearchInitialized) {
      temp = List.from(displayedUserCourses);
      isSearchInitialized = true;
    }

    setState(() {
      if (searchInput.isEmpty) {
        displayedUserCourses = temp;
        isSearchInitialized = false;
      } else {
        displayedUserCourses = displayedUserCourses.where((course) {
          return course.name.toLowerCase().contains(searchInput) ||
              course.slug.toLowerCase().contains(searchInput);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSearchTopNavBarWithBackButton(
        searchController: searchController,
        onSortOptionSelected: _handleSortOptionSelected,
        filterOptions: const ['Newest First', 'Oldest First', 'Semester'],
        onSemesterSelected: filterCoursesBySemester,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userViewModelProvider.notifier).fetchUserCourses();
        },
        child: CoursesList(
          title: 'My Courses',
          courses: displayedUserCourses,
          onRefresh: () async {
            await ref.read(userViewModelProvider.notifier).fetchUserCourses();
          },
        ),
      ),
    );
  }
}
