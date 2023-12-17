import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/user/mockData.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_section.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/my_courses_view.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/public_courses_view.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

import 'list_courses_view/live_courses_view.dart';

// current index of the bottom navigation bar (0 = My Courses, 1 = Public Courses)
final currentIndexProvider = StateProvider<int>((ref) => 0);

class CourseOverview extends ConsumerStatefulWidget {
  const CourseOverview({super.key});

  @override
  CourseOverviewState createState() => CourseOverviewState();
}

class CourseOverviewState extends ConsumerState<CourseOverview> {
  @override
  void initState() {
    super.initState();
    ref.read(userViewModelProvider.notifier);
    Future.microtask(() {
      // Fetch user courses if the user is logged in
      ref.read(userViewModelProvider).userCourses;
      ref.read(userViewModelProvider).publicCourses;
      ref.read(userViewModelProvider).userPinned;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(userViewModelProvider).user != null;
    var userCourses = ref.watch(userViewModelProvider).userCourses;
    var publicCourses = ref.watch(userViewModelProvider).publicCourses;
    var liveCourses = ref.watch(userViewModelProvider).liveCourses;

    return BaseView(
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
        onRefresh: () async {
          //final userViewModelNotifier =
          ref.read(userViewModelProvider.notifier);
          userCourses = ref.read(userViewModelProvider).userCourses;
          publicCourses = ref.read(userViewModelProvider).publicCourses;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLoggedIn)
                CourseSection(
                  sectionTitle: "Live Now",
                  onViewAll: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LiveCourses()),
                  ),
                  courses: MockData.liveCourses, //liveCourses,
                ),

              CourseSection(
                sectionTitle: "My Courses",
                onViewAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyCourses()),
                ),
                courses: userCourses ?? [],
              ),
              //const SizedBox(height: 5), // Space between the sections
              CourseSection(
                sectionTitle: "Public Courses",
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
