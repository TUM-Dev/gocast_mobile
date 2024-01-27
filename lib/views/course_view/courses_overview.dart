import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_section.dart';
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
      }
      // Fetch public courses regardless of user's login status
      userViewModelNotifier.fetchPublicCourses();
      userViewModelNotifier.fetchSemesters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(userViewModelProvider).user != null;
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
                if (isLoggedIn)
                  Center(
                    child: _buildSection(
                      "Live Now",
                      0,
                      (userCourses ?? []) + (publicCourses ?? []),
                      liveStreams,
                    ),
                  ),
                if (isTablet)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSection(
                          "My Courses",
                          1,
                          userCourses,
                          liveStreams,
                        ),
                      ),
                      Expanded(
                        child: _buildSection(
                          "Public Courses",
                          2,
                          publicCourses,
                          liveStreams,
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildSection(
                    "My Courses",
                    1,
                    userCourses,
                    liveStreams,
                  ),
                  _buildSection(
                    "Public Courses",
                    2,
                    publicCourses,
                    liveStreams,
                  ),
                ],
              ],
            ),
          ),
    )
    );
  }

  Widget _buildSection(String title, int sectionKind, courses, streams) {
    return CourseSection(
      ref: ref,
      sectionTitle: title,
      sectionKind: sectionKind,
      onViewAll: () {
        switch (title) {
          case "My Courses":
            _navigateTo(const MyCourses());
            break;
          case "Public Courses":
            _navigateTo(const PublicCourses());
            break;
        }
      },
      courses: courses ?? [],
      streams: streams ?? [],
    );
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
  }

}
