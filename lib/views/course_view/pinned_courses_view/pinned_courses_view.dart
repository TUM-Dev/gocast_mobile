
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar.dart';
import 'package:gocast_mobile/views/course_view/components/course_card.dart';
import 'package:gocast_mobile/views/course_view/course_detail_view/course_detail_view.dart';
import 'package:gocast_mobile/views/course_view/pinned_courses_view/pinned_courses_content_view.dart';
import 'package:gocast_mobile/views/video_view/video_player_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PinnedCourses extends ConsumerStatefulWidget {
  const PinnedCourses({super.key});

  @override
  PinnedCoursesState createState() => PinnedCoursesState();
}

class PinnedCoursesState extends ConsumerState<PinnedCourses> {
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
    final pinnedCourseViewModelNotifier =
        ref.read(pinnedCourseViewModelProvider.notifier);
    Future.microtask(() async {
      await pinnedCourseViewModelNotifier.fetchUserPinned();
    });
  }

  Future<void> _refreshPinnedCourses() async {
    await ref.read(pinnedCourseViewModelProvider.notifier).fetchUserPinned();
  }

  void filterCoursesBySemester(String selectedSemester) {
    var userPinned = ref.watch(pinnedCourseViewModelProvider).userPinned ?? [];
    ref
        .read(pinnedCourseViewModelProvider.notifier)
        .updateSelectedPinnedSemester(selectedSemester, userPinned);
  }

  void _searchCourses() {
    final pinnedViewModelNotifier =
        ref.read(pinnedCourseViewModelProvider.notifier);
    final searchInput = searchController.text.toLowerCase();
    var displayedCourses =
        ref.watch(pinnedCourseViewModelProvider).displayedPinnedCourses ?? [];
    if (!isSearchInitialized) {
      temp = List.from(displayedCourses);
      isSearchInitialized = true;
    }
    if (searchInput.isEmpty) {
      pinnedViewModelNotifier.updatedDisplayedPinnedCourses(temp);
      isSearchInitialized = false;
    } else {
      displayedCourses = temp.where((course) {
        return course.name.toLowerCase().contains(searchInput) ||
            course.slug.toLowerCase().contains(searchInput);
      }).toList();
      pinnedViewModelNotifier.updatedDisplayedPinnedCourses(displayedCourses);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userPinned =
        ref.watch(pinnedCourseViewModelProvider).displayedPinnedCourses ?? [];
    final liveStreams = ref.watch(videoViewModelProvider).liveStreams ?? [];
    var liveCourseIds = liveStreams.map((stream) => stream.courseID).toSet();
    List<Course> liveCourses = userPinned
        .where((course) => liveCourseIds.contains(course.id))
        .toList();
    final filterOptions =
        ref.watch(userViewModelProvider).semestersAsString ?? [];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshPinnedCourses,
        child: PinnedCoursesContentView(
          customAppBar: CustomSearchTopNavBar(
            searchController: searchController,
            title: AppLocalizations.of(context)!.pinned_courses,
            filterOptions: filterOptions,
            onClick: filterCoursesBySemester,
          ),
          pinnedCourseCards: userPinned.map((course) {
            final isPinned =
                userPinned.any((pinnedCourse) => pinnedCourse.id == course.id);
            return CourseCard(
              isLoggedIn: true,
              course: course,
              isPinned: isPinned,
              onPinUnpin: (course) => _togglePin(course, isPinned),
              live: liveCourses.contains(course),
              title: course.name,
              courseId: course.id,
              subtitle: course.tUMOnlineIdentifier,
              tumID: course.tUMOnlineIdentifier,
              onTap: () => _handleCourseTap(course, context),
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
    final pinnedViewModel = ref.read(pinnedCourseViewModelProvider.notifier);
    if (isPinned) {
      await pinnedViewModel.unpinCourse(course.id);
    } else {
      await pinnedViewModel.pinCourse(course.id);
    }
    await _refreshPinnedCourses();
  }

  VideoSourceType determineSourceType(String videoSource) {
    return videoSource.startsWith('http')
        ? VideoSourceType.network
        : VideoSourceType.asset;
  }
}
