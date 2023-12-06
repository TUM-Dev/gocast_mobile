import 'package:flutter/material.dart';
import 'package:gocast_mobile/models/course/course_model.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/viewall_button_view.dart';
import 'package:gocast_mobile/views/course_view/components/course_card_view.dart';

/// CourseSection
///
/// A reusable stateless widget to display a specific course section.
///
/// It takes a [sectionTitle] to display the title of the section and
/// dynamically generates a horizontal list of courses. This widget can be
/// reused for various course sections by providing different titles and
/// course lists.
///
/// This widget also takes an [onViewAll] action to define the action to be
/// performed when the user taps on the View All button.
/// This widget also takes a [courses] list to display the list of courses.
/// If no courses are provided, it will display a default list of courses.
/// This widget can be reused for various course sections by providing
/// different titles, courses and onViewAll actions.
class CourseSection extends StatelessWidget {
  final String sectionTitle;
  final List<CourseModel>? courses;
  final VoidCallback onViewAll;

  const CourseSection({
    super.key,
    required this.sectionTitle,
    required this.onViewAll,
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
            onViewAll: onViewAll,
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
    required List<CourseModel> courses,
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
                final course = courses[index];
                return CourseCard(
                  title: course.title,
                  subtitle: course.subtitle,
                  path: course.imagePath,
                );
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

  List<CourseModel> _defaultCourses() {
    return [
      CourseModel(
        title: 'PSY101',
        subtitle: 'Introduction to Psychology',
        imagePath: AppImages.course1,
      ),
      CourseModel(
        title: 'PSY102',
        subtitle: 'Introduction to Computer Science',
        imagePath: AppImages.course2,
      ),
      CourseModel(
        title: 'PSY103',
        subtitle: 'Introduction to Biology',
        imagePath: AppImages.course1,
      ),
      CourseModel(
        title: 'PSY104',
        subtitle: 'Introduction to Chemistry',
        imagePath: AppImages.course2,
      ),
      CourseModel(
        title: 'PSY105',
        subtitle: 'Introduction to Physics',
        imagePath: AppImages.course1,
      ),
    ];
  }
}
