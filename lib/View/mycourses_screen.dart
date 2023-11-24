import 'package:flutter/material.dart';
import 'package:gocast_mobile/View/utils/custom_bottom_nav_bar.dart';
import 'settings_screen.dart';
import 'package:gocast_mobile/View/utils/course_card_view.dart';
class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Courses',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal list view for My Courses
            SizedBox(
              height: 200, // Adjust the height as needed
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:  const [
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
          ],
        ),
      ),
     bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

