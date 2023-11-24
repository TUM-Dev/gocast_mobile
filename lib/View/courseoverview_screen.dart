import 'package:flutter/material.dart';
import 'package:gocast_mobile/View/utils/custom_bottom_nav_bar.dart';
import 'package:gocast_mobile/View/mycourses_screen.dart';
import 'package:gocast_mobile/View/publiccourses_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/View/utils/viewall_button_view.dart';
import 'settings_screen.dart';
import 'package:gocast_mobile/View/utils/course_card_view.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class CourseOverview extends ConsumerWidget {
  const CourseOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Replace with the exact color
        title: const Text(
          'GoCast',
          style: TextStyle(color: Colors.black),
        ), // Replace with the exact color
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ), // Replace with the exact color
            onPressed: () {
              // Settings action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Courses',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
               ViewAllButton(
                onViewAll: () { Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyCourses(),
                  ),
                );
                  }, // Use the reusable ViewAllButton widget
              ),
                ],
              ),
            ),
            // Horizontal list view for My Courses
            SizedBox(
              height: 200, // Adjust the height as needed
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CourseCard(
                    title: 'PSY101',
                    subtitle: 'Introduction to Psychology',
                    path: 'assets/images/course1.png',
                  ),
                  CourseCard(
                    title: 'CS202',
                    subtitle: 'Introduction to Computer Science',
                      path: 'assets/images/course2.png',
                  ),
                  // Add more courses as needed
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Public Courses',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ViewAllButton(
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PublicCourses(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Horizontal list view for Public Courses
            SizedBox(
              height: 200, // Adjust the height as needed
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:  const [
                  CourseCard(
                    title: 'PSY101',
                    subtitle: 'Public Psychology Course',
                      path: 'assets/images/course1.png',
                  ),
                  CourseCard(
                    title: 'PSY101',
                    subtitle: 'Public Psychology Course',
                      path: 'assets/images/course2.png',
                  ),
                  // Add more courses as needed
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

