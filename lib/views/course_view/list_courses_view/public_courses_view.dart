import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/sort_utils.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar_back_button.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/courses_list_view.dart';

class PublicCourses extends ConsumerStatefulWidget {
  const PublicCourses({super.key});

  @override
  PublicCoursesState createState() => PublicCoursesState();
}

class PublicCoursesState extends ConsumerState<PublicCourses> {
  late List<Course> displayedPublicCourses = [];
  late List<Course> allPublicCourses = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();
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
    Future.microtask(() async {
      await userViewModelNotifier.fetchUserPinned();
      if (mounted) {
        setState(() {
          allPublicCourses =
              ref.read(userViewModelProvider).publicCourses ?? [];
          displayedPublicCourses = allPublicCourses;
          isLoading = false; // Set isLoading to false here
          _handleSortOptionSelected('Semester');
          filterCoursesBySemester(
              ref.read(userViewModelProvider).currentAsString ?? 'All');
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
          displayedPublicCourses,
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
      displayedPublicCourses = CourseUtils.filterCoursesBySemester(
          allPublicCourses, selectedSemester);
    });
  }

  void _searchCourses() {
    final searchInput = searchController.text.toLowerCase();
    if (!isSearchInitialized) {
      temp = List.from(displayedPublicCourses);
      isSearchInitialized = true;
    }

    setState(() {
      if (searchInput.isEmpty) {
        displayedPublicCourses = temp;
        isSearchInitialized = false;
      } else {
        displayedPublicCourses = displayedPublicCourses.where((course) {
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
      body: CoursesList(
        title: 'Public Courses',
        courses: displayedPublicCourses,
        onRefresh: _refreshPublicCourses,
      ),
    );
  }

  Future<void> _refreshPublicCourses() async {
    await ref.read(userViewModelProvider.notifier).fetchPublicCourses();
    final selectedSemester =
        ref.read(userViewModelProvider).selectedSemester ?? 'All';
    if (mounted) {
      setState(() {
        allPublicCourses = ref.watch(userViewModelProvider).publicCourses ?? [];
        displayedPublicCourses = allPublicCourses;
        _handleSortOptionSelected(
            ref.read(userViewModelProvider).selectedFilterOption);
        filterCoursesBySemester(selectedSemester);
      });
    }
  }
}
