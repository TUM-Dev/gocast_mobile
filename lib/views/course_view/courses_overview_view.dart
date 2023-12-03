import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/main.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_overview_section.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/my_courses_view.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/public_courses_view.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

// current index of the bottom navigation bar (0 = My Courses, 1 = Public Courses)
final currentIndexProvider = StateProvider<int>((ref) => 0);

/// CourseOverview
///
/// A widget that displays an overview of different course sections such as
/// "My Courses" and "Public Courses" in a scrollable column layout.
///
/// It includes an AppBar and a BottomNavigationBar that remain static,
/// while the content can scroll independently. This design ensures that the
/// AppBar and BottomNavigationBar are not rebuilt unnecessarily, improving
/// the performance and user experience.
class CourseOverview extends ConsumerWidget {
  const CourseOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.read(userViewModel).current.value.user != null;

    return BaseView(
      title: 'Go Cast',
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => _navigateToScreen(
            context,
            const SettingsScreen(),
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLoggedIn)
              CourseSection(
                sectionTitle: "My courses",
                onViewAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyCourses()),
                ),
              ),
            const SizedBox(height: 20), // Space between the sections
            CourseSection(
              sectionTitle: "Public courses",
              onViewAll: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PublicCourses()),
              ),
            ),
            // Add other sections or content as needed
          ],
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
