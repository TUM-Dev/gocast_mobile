import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/View/bookmarks_screen.dart';
import 'package:gocast_mobile/View/download_screen.dart';
import 'courseoverview_screen.dart';

class NotificationsScreen extends ConsumerWidget {
  NotificationsScreen({super.key});

  final Map<String, List<String>> notifications = {
    'Today': [
      'Lineare Algebra für Informatik is live now!',
      'Functional Programming and verification is live now!',
    ],
    'Yesterday': [
      'Lineare Algebra für Informatik is live now!',
      'Functional Programming and verification is live now!',
    ],
    'November 25': [
      'Lineare Algebra für Informatik is live now!',
      'Functional Programming and verification is live now!',
    ],
    // Add more data here
  };

  void _navigateToScreen(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>  const CourseOverview()),
              (Route<dynamic> route) => false,
        );
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DownloadsScreen()),
        );
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BookmarksScreen()),
        );
        break;
      case 3:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>  NotificationsScreen()),
              (Route<dynamic> route) => false,
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.keys.length,
        itemBuilder: (context, index) {
          String key = notifications.keys.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  key,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...notifications[key]!.map(
                (notification) => ListTile(
                  title: Text(notification),
                  trailing: const Text('06:30'),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _navigateToScreen(index, context),
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
              color: Colors.grey,
            ), // Replace with the exact color
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.blue,
            ), // Replace with the exact color
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
