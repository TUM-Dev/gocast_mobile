import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/main.dart';
import 'package:gocast_mobile/views/course_view/downloaded_pinned_courses_view/pinned_courses_view.dart';
import 'package:gocast_mobile/views/notifications_view/notifications_screen_view.dart';

import '../course_view/courses_overview_view.dart';
import '../course_view/downloaded_pinned_courses_view/downloaded_courses_view.dart';

// Assuming currentIndexProvider is defined in a global scope file:
// final currentIndexProvider = StateProvider<int>((ref) => 0);

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  Color _getColorForIcon(BuildContext context, int index, int currentIndex) {
    // Use theme colors instead of hardcoded ones
    return index == currentIndex
        ? Theme.of(context).colorScheme.primary
        : Colors.grey;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final isLoggedIn = ref.read(userViewModel).current.value.user != null;

    void navigateToScreen(int index) {
      if (currentIndex == index) {
        return;
      }
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
            MaterialPageRoute(builder: (context) => const DownloadedCourses()),
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

    return isLoggedIn
        ? BottomNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            currentIndex: currentIndex,
            onTap: navigateToScreen,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _getColorForIcon(context, 0, currentIndex),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.download,
                  color: _getColorForIcon(context, 1, currentIndex),
                ),
                label: 'Downloads',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.push_pin,
                  color: _getColorForIcon(context, 2, currentIndex),
                ),
                label: 'Pinned',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: _getColorForIcon(context, 3, currentIndex),
                ),
                label: 'Notifications',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          )
        : Container(height: 0);
  }
}
