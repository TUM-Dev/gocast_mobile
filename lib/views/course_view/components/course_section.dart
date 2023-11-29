import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/components/viewall_button_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_card_view.dart';
import 'package:gocast_mobile/views/utils/constants.dart';

///
/// CourseSection is a widget that displays a section of courses.
/// It is used in the CourseOverview screen to display the user's courses and public courses.
///  * [sectionTitle] is the title of the section.
///  * [courses] is a list of CourseCard widgets to display.
///  * [onViewAll] is the action to perform when the user taps the View All button.
///  * [context] is the BuildContext.
class CourseSection extends StatelessWidget {
  final String sectionTitle;
  final List<Widget>? courses;

  const CourseSection({
    super.key,
    required this.sectionTitle,
    this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCourseSection(
            context: context,
            title: sectionTitle,
            onViewAll: () {}, // Define the onViewAll action
            courses: courses ?? _defaultCourses(),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseSection({
    required BuildContext context,
    required String title,
    required VoidCallback onViewAll,
    required List<Widget> courses,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title, onViewAll),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: courses,
            ),
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

  List<Widget> _defaultCourses() {
    return const [
      CourseCard(
        title: 'PSY101',
        subtitle: 'Introduction to Psychology',
        path: AppImages.course1,
      ),
      CourseCard(
        title: 'PSY102',
        subtitle: 'Introduction to Computer Science',
        path: AppImages.course2,
      ),
      CourseCard(
        title: 'PSY103',
        subtitle: 'Introduction to Biology',
        path: AppImages.course1,
      ),
      CourseCard(
        title: 'PSY104',
        subtitle: 'Introduction to Chemistry',
        path: AppImages.course2,
      ),
      CourseCard(
        title: 'PSY105',
        subtitle: 'Introduction to Physics',
        path: AppImages.course1,
      ),
    ];
  }
}
