import 'package:flutter/material.dart';
import 'package:gocast_mobile/View/utils/custom_bottom_nav_bar.dart';
import 'package:gocast_mobile/View/utils/constants.dart';
import 'package:gocast_mobile/View/settings_screen.dart';

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
      backgroundColor: appBarBackgroundColor,
      title: const Text('GoCast', style: TextStyle(color: appBarTextColor)),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: appBarIconColor),
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
        style: sectionTitleTextStyle,
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
