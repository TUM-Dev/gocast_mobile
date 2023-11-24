import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../courseoverview_screen.dart';
import '../download_screen.dart';
import 'package:gocast_mobile/views/pinnedcourses_screen.dart';
import 'package:gocast_mobile/views/notifications_screen.dart';

// Assuming currentIndexProvider is defined in a global scope file:
// final currentIndexProvider = StateProvider<int>((ref) => 0);

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  Color _getColorForIcon(int index, int currentIndex) {
    return index == currentIndex ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    void navigateToScreen(int index) {
      ref.read(currentIndexProvider.notifier).state = index; // Update the state
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
            MaterialPageRoute(builder: (context) => const PinnedCourses()),
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

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: navigateToScreen,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: _getColorForIcon(0, currentIndex)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.file_download,
            color: _getColorForIcon(1, currentIndex),
          ),
          label: 'Downloads',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.push_pin, color: _getColorForIcon(2, currentIndex)),
          label: 'Pinned',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications,
            color: _getColorForIcon(3, currentIndex),
          ),
          label: 'Notifications',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
