import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';
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
  String selectedSemester = 'All';
  late List<Course> temp;
  bool isSearchInitialized = false;

  void filterCoursesBySemester(String selectedSemester) {
    if (selectedSemester == 'All') {
      setState(() {
        displayedUserCourses = allUserCourses;
      });
    } else {
      var parts =
          selectedSemester.split(' - '); // Assuming the format is "year - term"
      var year = int.parse(parts[0]);
      var term = parts[1];

      setState(() {
        displayedUserCourses = allUserCourses.where((course) {
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
          allUserCourses = ref.read(userViewModelProvider).userCourses ?? [];
          displayedUserCourses = allUserCourses;
          isLoading = false; // Set isLoading to false here
        });
        sortCourses();
      }
    });
  }

  void sortCourses() {
    displayedUserCourses.sort((a, b) {
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
      temp = List.from(displayedUserCourses);
      isSearchInitialized = true;
    }

    setState(() {
      if (searchInput.isEmpty) {
        displayedUserCourses =
            allUserCourses; // Reset to the full list when search is cleared
        isSearchInitialized = false;
      } else {
        var filteredCourses = allUserCourses.where((course) {
          return course.name.toLowerCase().contains(searchInput) ||
              course.slug.toLowerCase().contains(searchInput);
        }).toList();

        // Check if the search yields no results and show placeholder in that case
        if (filteredCourses.isEmpty) {
          displayedUserCourses =
              []; // This will trigger the placeholder in CoursesList
        } else {
          displayedUserCourses = filteredCourses;
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
            semesters, true), // Replace with your actual filter options
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
