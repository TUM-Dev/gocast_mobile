import 'package:flutter/material.dart';
import 'settings_screen.dart';

class PublicCourses extends StatelessWidget {
  const PublicCourses({super.key});

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
                    'Public Courses',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal list view for Public Courses
            SizedBox(
              height: 200, // Adjust the height as needed
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CourseCard(
                    title: 'PSY101',
                    subtitle: 'Public Psychology Course',
                  ),
                  CourseCard(
                    title: 'PSY101',
                    subtitle: 'Public Psychology Course',
                  ),
                  // Add more courses as needed
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ), // Replace with the exact color
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.download,
              color: Colors.grey,
            ), // Replace with the exact color
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: Colors.grey,
            ), // Replace with the exact color
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
            ), // Replace with the exact color
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const CourseCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Adjust the width as needed
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              'path_to_your_course_image', // Replace with the actual path to your course image
              fit: BoxFit.cover,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ), // Replace with the exact color
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ), // Replace with the exact color
          ),
        ],
      ),
    );
  }
}
