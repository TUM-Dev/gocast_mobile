import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';
import 'package:gocast_mobile/views/utils/constants.dart';
import 'package:gocast_mobile/views/utils/custom_bottom_nav_bar.dart';

class CoursesScreen extends StatelessWidget {
  final String title;
  final List<Widget> courseCards;

  const CoursesScreen({
    super.key,
    required this.title,
    required this.courseCards,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(),
            _buildCourseListView(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: const Text('GoCast'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          ),
        ),
      ],
    );
  }

  Padding _buildSectionTitle() {
    return Padding(
      padding: sectionPadding,
      child: Text(
        title,
      ),
    );
  }

  SizedBox _buildCourseListView() {
    return SizedBox(
      height: courseListHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: courseCards,
      ),
    );
  }
}
