import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_view/components/course_card_view.dart';
import 'package:gocast_mobile/views/course_view/my_courses_view.dart';
import 'package:gocast_mobile/views/course_view/public_courses_view.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';
import 'package:gocast_mobile/views/utils/constants.dart';
import 'package:gocast_mobile/views/components/custom_bottom_nav_bar.dart';
import 'package:gocast_mobile/views/components/viewall_button_view.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class CourseOverview extends ConsumerWidget {
  const CourseOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseSection(
              context: context,
              title: 'My Courses',
              onViewAll: () => _navigateToScreen(context, const MyCourses()),
            ),
            _buildCourseSection(
              context: context,
              title: 'Public Courses',
              onViewAll: () =>
                  _navigateToScreen(context, const PublicCourses()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('GoCast'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => _navigateToScreen(context, const SettingsScreen()),
        ),
      ],
    );
  }

  Widget _buildCourseSection({
    required BuildContext context,
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title, onViewAll),
          SizedBox(
            height: 200,
            child: _buildCourseListView(),
          ),
        ],
      ),
    );
  }

  Row _buildSectionTitle(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ViewAllButton(onViewAll: onViewAll),
      ],
    );
  }

  ListView _buildCourseListView() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        CourseCard(
          title: 'PSY101',
          subtitle: 'Introduction to Psychology',
          path: AppImages.course1,
        ),
        CourseCard(
          title: 'PSY101',
          subtitle: 'Introduction to Computer Science',
          path: AppImages.course2,
        ),
        // ... Add more courses as needed
      ],
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
