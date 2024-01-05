import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_section.dart';
import 'package:gocast_mobile/views/course_view/components/livenow_section.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/my_courses_view.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/public_courses_view.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

// current index of the bottom navigation bar (0 = My Courses, 1 = Public Courses)

class LiveNowOverview extends ConsumerStatefulWidget {
  const LiveNowOverview({super.key});

  @override
  LiveNowOverviewState createState() => LiveNowOverviewState();
}

class LiveNowOverviewState extends ConsumerState<LiveNowOverview> {
  @override
  void initState() {
    super.initState();
    final userViewModelNotifier = ref.read(userViewModelProvider.notifier);

    Future.microtask(() {
      // Fetch user courses if the user is logged in
      if (ref.read(userViewModelProvider).user != null) {
        userViewModelNotifier.fetchUserCourses();
      }
      // Fetch public courses regardless of user's login status
      userViewModelNotifier.fetchPublicCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(userViewModelProvider).user != null;
    final userCourses = ref.watch(userViewModelProvider).userCourses;
    final publicCourses = ref.watch(userViewModelProvider).publicCourses;

    return BaseView(
      showLeading: false,
      title: 'Courses',
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
        onRefresh: () async {
          final userViewModelNotifier =
              ref.read(userViewModelProvider.notifier);
          final videoViewModelNotifier =
              ref.read(videoViewModelProvider.notifier);
          await userViewModelNotifier.fetchUserCourses();
          await userViewModelNotifier.fetchPublicCourses();
          await videoViewModelNotifier.fetchCourseStreams(1);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLoggedIn)
                LivenowSection(
                  sectionTitle: "Live Now",
                  courses: userCourses ?? [],
                ),

              CourseSection(
                sectionTitle: "My courses",
                onViewAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyCourses()),
                ),
                courses: userCourses ?? [],
              ),
              //const SizedBox(height: 5), // Space between the sections
              CourseSection(
                sectionTitle: "Public courses",
                onViewAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PublicCourses(),
                  ),
                ),
                courses: publicCourses ?? [],
              ),
              // Add other sections or content as needed
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
