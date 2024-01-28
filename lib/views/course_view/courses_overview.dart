import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/section_kind.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_section.dart';
import 'package:gocast_mobile/views/course_view/components/live_stream_section.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/my_courses_view.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/public_courses_view.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

// current index of the bottom navigation bar (0 = My Courses, 1 = Public Courses)
class CourseOverview extends ConsumerStatefulWidget {
  const CourseOverview({super.key});

  @override
  CourseOverviewState createState() => CourseOverviewState();
}

class CourseOverviewState extends ConsumerState<CourseOverview> {
  @override
  void initState() {
    super.initState();
    final userViewModelNotifier = ref.read(userViewModelProvider.notifier);
    final videoViewModelNotifier = ref.read(videoViewModelProvider.notifier);

    Future.microtask(() {
      // Fetch user courses if the user is logged in
      if (ref.read(userViewModelProvider).user != null) {
        userViewModelNotifier.fetchUserCourses();
        videoViewModelNotifier.fetchLiveNowStreams();
        userViewModelNotifier.fetchUserPinned();
      }
      // Fetch public courses regardless of user's login status
      userViewModelNotifier.fetchPublicCourses();
      userViewModelNotifier.fetchSemesters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCourses = ref.watch(userViewModelProvider).userCourses;
    final publicCourses = ref.watch(userViewModelProvider).publicCourses;
    final liveStreams = ref.watch(videoViewModelProvider).liveStreams;

    bool isTablet = MediaQuery.of(context).size.width >= 600 ? true : false;
    return PopScope(
      canPop: false,
      child: BaseView(
        showLeading: false,
        title: 'GoCast',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _navigateToScreen(
              context,
              const SettingsScreen(),
            ),
          ),
        ],
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            children: [
                Center(
                    child: LiveStreamSection(
                  ref: ref,
                  sectionTitle: "Live Now",
                  courses: (userCourses ?? []) + (publicCourses ?? []),
                  streams: liveStreams ?? [],
                ),
              ),
              if (isTablet)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildSection(
                        "My Courses",
                        SectionKind.myCourses,
                        userCourses,
                        liveStreams,
                      ),
                    ),
                    Expanded(
                      child: _buildSection(
                        "Public Courses",
                        SectionKind.publicCourses,
                        publicCourses,
                        liveStreams,
                      ),
                    ),
                  ],
                )
              else ...[
                _buildSection(
                  "My Courses",
                  SectionKind.myCourses,
                  userCourses,
                  liveStreams,
                ),
                _buildSection(
                  "Public Courses",
                  SectionKind.publicCourses,
                  publicCourses,
                  liveStreams,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title,
      SectionKind sectionKind,
      courses,
      streams,) {
    return CourseSection(
      ref: ref,
      sectionTitle: title,
      sectionKind: sectionKind,
      onViewAll: () => _onViewAllPressed(title),
      courses: courses ?? [],
      streams: streams ?? [],
    );
  }

  void _onViewAllPressed(String title) {
    switch (title) {
      case "My Courses":
        _navigateTo(const MyCourses());
        break;
      case "Public Courses":
        _navigateTo(const PublicCourses());
        break;
      // Add more cases as needed
    }
  }

  void _navigateTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<void> _refreshData() async {
    final userViewModelNotifier = ref.read(userViewModelProvider.notifier);
    await userViewModelNotifier.fetchUserCourses();
    await userViewModelNotifier.fetchPublicCourses();
    await ref.read(videoViewModelProvider.notifier).fetchLiveNowStreams();
  }
}
