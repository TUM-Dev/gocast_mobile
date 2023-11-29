import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/components/viewall_button_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_card_view.dart';
import 'package:gocast_mobile/views/utils/constants.dart';

/// CourseSection
///
/// A reusable stateless widget to display a specific course section.
///
/// It takes a [sectionTitle] to display the title of the section and
/// dynamically generates a horizontal list of courses. This widget can be
/// reused for various course sections by providing different titles and
/// course lists.
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (BuildContext context, int index) {
                return courses[index];
              },
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
