import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';
import 'package:gocast_mobile/views/utils/constants.dart';

/// CoursesScreen
///
/// This screen displays a list of courses.
///
/// It takes a [title] to display the title of the section and
/// dynamically generates a horizontal list of courses. This widget can be
/// reused for various course sections by providing different titles and
/// course lists.
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
    return BaseView(
      title: 'GoCast',
      actions: _buildAppBarActions(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(),
            _buildCourseListView(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        ),
      ),
    ];
  }

  Padding _buildSectionTitle() {
    return Padding(
      padding: AppPadding.sectionPadding,
      child: Text(
        title,
      ),
    );
  }

  SizedBox _buildCourseListView() {
    return SizedBox(
      height: AppSizes.courseListHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courseCards.length,
        itemBuilder: (BuildContext context, int index) {
          return courseCards[index];
        },
      ),
    );
  }
}
