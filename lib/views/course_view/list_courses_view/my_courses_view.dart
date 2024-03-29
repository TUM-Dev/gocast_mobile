import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar_back_button.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/courses_list_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyCourses extends ConsumerStatefulWidget {
  const MyCourses({super.key});

  @override
  MyCoursesState createState() => MyCoursesState();
}

class MyCoursesState extends ConsumerState<MyCourses> {
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
      await userViewModelNotifier.fetchUserCourses();
    });
  }

  Future<void> _refreshMyCourses() async {
    await ref.read(userViewModelProvider.notifier).fetchUserCourses();
  }

  void filterCoursesBySemester(String selectedSemester) {
    var allUserCourses = ref.watch(userViewModelProvider).userCourses ?? [];
    ref
        .read(pinnedCourseViewModelProvider.notifier)
        .setSelectedSemester(selectedSemester);
    ref
        .read(userViewModelProvider.notifier)
        .updateSelectedSemester(selectedSemester, allUserCourses);
  }

  void _searchCourses() {
    final userViewModelNotifier = ref.read(userViewModelProvider.notifier);
    final searchInput = searchController.text.toLowerCase();
    var displayedCourses =
        ref.watch(userViewModelProvider).displayedCourses ?? [];
    if (!isSearchInitialized) {
      temp = List.from(displayedCourses);
      isSearchInitialized = true;
    }

    if (searchInput.isEmpty) {
      userViewModelNotifier.updatedDisplayedCourses(temp);
      isSearchInitialized = false;
    } else {
      displayedCourses = temp.where((course) {
        return course.name.toLowerCase().contains(searchInput) ||
            course.slug.toLowerCase().contains(searchInput);
      }).toList();
      userViewModelNotifier.updatedDisplayedCourses(displayedCourses);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myCourses = ref.watch(userViewModelProvider).displayedCourses ?? [];
    final filterOptions =
        ref.watch(userViewModelProvider).semestersAsString ?? [];
    return Scaffold(
      appBar: CustomSearchTopNavBarWithBackButton(
        searchController: searchController,
        filterOptions: filterOptions,
        onClick: filterCoursesBySemester,
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: _refreshMyCourses,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          dragStartBehavior: DragStartBehavior.down,
          children: [
            CoursesList(
              title: AppLocalizations.of(context)!.my_courses,
              courses: myCourses,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
