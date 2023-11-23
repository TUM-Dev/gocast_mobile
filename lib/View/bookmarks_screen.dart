import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'courseoverview_screen.dart';
import 'download_screen.dart';
import 'notifications_screen.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

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
        title: const Text('Bookmarks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Implement more options functionality
            },
          ),
        ],
      ),
      body: ListView(
        children: const <Widget>[
          DownloadItem(
            imageName: 'assets/lecture_hall.jpg',
            title: 'Lineare Algebra für Informatik [MA0901]',
            date: 'July 24, 2019',
            duration: '02:00:00',
          ),
          DownloadItem(
            imageName: 'assets/computer_science.jpg',
            title: 'Computer Science [CS202]',
            date: 'July 23, 2019',
            duration: '02:00:00',
          ),
          // Add more DownloadItem widgets as needed
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => navigateToScreen(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
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
              color: Colors.blue,
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

class DownloadItem extends StatelessWidget {
  final String imageName;
  final String title;
  final String date;
  final String duration;

  const DownloadItem({
    super.key,
    required this.imageName,
    required this.title,
    required this.date,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageName), // Replace with actual image paths
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(date),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Chip(
                    label: Text(duration),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
