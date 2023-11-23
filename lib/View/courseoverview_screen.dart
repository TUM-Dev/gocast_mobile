import 'package:flutter/material.dart';
import 'package:gocast_mobile/View/bookmarks_screen.dart';
import 'package:gocast_mobile/View/download_screen.dart';
import 'package:gocast_mobile/View/mycourses_screen.dart';
import 'notifications_screen.dart';
import 'package:gocast_mobile/View/publiccourses_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_screen.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class CourseOverview extends ConsumerWidget {
  const CourseOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateToScreen(int index, BuildContext context) {
      switch (index) {
        case 0:
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const CourseOverview()),
            (Route<dynamic> route) => false,
          );
          break;
        case 1:
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DownloadsScreen()),
            (Route<dynamic> route) => false,
          );
          break;
        case 2:
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const BookmarksScreen()),
            (Route<dynamic> route) => false,
          );
          break;
        case 3:
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => NotificationsScreen()),
            (Route<dynamic> route) => false,
          );
          break;
        default:
          break;
      }
    }

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
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyCourses(),
                        ),
                      );
                    },
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
                  ),
                  CourseCard(
                    title: 'CS202',
                    subtitle: 'Introduction to Computer Science',
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
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
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
        onTap: (index) => navigateToScreen(index, context),
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
              Icons.file_download,
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
