import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/custom_bottom_nav_bar.dart';
import 'package:gocast_mobile/views/course_view/components/course_section.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class CourseOverview extends ConsumerWidget {
  const CourseOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CourseSection(sectionTitle: "My courses"),
            SizedBox(height: 20), // Space between the sections
            CourseSection(sectionTitle: "Public courses"),
            // Add other sections or content as needed
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

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
