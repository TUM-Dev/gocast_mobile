import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';
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
  bool isNewestFirst = false;
  String selectedSemester = 'All';
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
        });
        sortCourses();
      }
    });
  }

  void filterCoursesBySemester(String selectedSemester) {
    if (selectedSemester == 'All') {
      setState(() {
        displayedPublicCourses = allPublicCourses;
      });
    } else {
      var parts =
          selectedSemester.split(' - '); // Assuming the format is "year - term"
      var year = int.parse(parts[0]);
      var term = parts[1];

      setState(() {
        displayedPublicCourses = allPublicCourses.where((course) {
          return course.semester.year == year &&
              course.semester.teachingTerm == term;
        }).toList();
      });
    }
  }

  List<String> convertAndSortSemesters(
    List<Semester> semesters,
    bool isNewestFirst,
  ) {
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

  void sortCourses() {
    displayedPublicCourses.sort((a, b) {
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
  }

  void _searchCourses() {
    final searchInput = searchController.text.toLowerCase();

    if (!isSearchInitialized) {
      temp = List.from(displayedPublicCourses);
      isSearchInitialized = true;
    }

    setState(() {
      if (searchInput.isEmpty) {
        displayedPublicCourses =
            allPublicCourses; // Reset to the full list when search is cleared
        isSearchInitialized = false;
      } else {
        var filteredCourses = allPublicCourses.where((course) {
          return course.name.toLowerCase().contains(searchInput) ||
              course.slug.toLowerCase().contains(searchInput);
        }).toList();

        // Check if the search yields no results and show placeholder in that case
        if (filteredCourses.isEmpty) {
          displayedPublicCourses =
              []; // This will trigger the placeholder in CoursesList
        } else {
          displayedPublicCourses = filteredCourses;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final semesters = ref.watch(userViewModelProvider).semesters ?? [];
    return Scaffold(
      appBar: CustomSearchTopNavBarWithBackButton(
        searchController: searchController,
        onSortOptionSelected: _handleSortOptionSelected,
        filterOptions: const ['Newest First', 'Oldest First', 'Semester'],
        onSemesterSelected: filterCoursesBySemester,
        semesters: convertAndSortSemesters(
            semesters, true), // Replace with actual filter options
      ),
      body: CoursesList(
        title: 'Public Courses',
        courses: displayedPublicCourses,
        onRefresh: () async {
          await ref.read(userViewModelProvider.notifier).fetchPublicCourses();
        },
      ),
    );
  }
}
