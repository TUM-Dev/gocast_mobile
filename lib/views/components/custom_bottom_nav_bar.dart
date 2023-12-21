import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/course_view/pinned_courses_view/pinned_courses_view.dart';
import 'package:gocast_mobile/views/notifications_view/notifications_screen_view.dart';

import 'package:gocast_mobile/views/course_view/courses_overview.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/downloaded_courses_view.dart';

import '../notifications_view/notifications_overview.dart';

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
    final isLoggedIn = ref.read(userViewModelProvider).user != null;

    return isLoggedIn
        ? BottomNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            currentIndex: currentIndex,
            onTap: (index) => _onItemTapped(context, ref, index, currentIndex),
            items: [
              _buildNavigationBarItem(
                Icons.home,
                'Home',
                context,
                currentIndex,
                0,
              ),
              _buildNavigationBarItem(
                Icons.download,
                'Downloads',
                context,
                currentIndex,
                1,
              ),
              _buildNavigationBarItem(
                Icons.push_pin,
                'Pinned',
                context,
                currentIndex,
                2,
              ),
              _buildNavigationBarItem(
                Icons.notifications,
                'Notifications',
                context,
                currentIndex,
                3,
              ),
            ],
            type: BottomNavigationBarType.fixed,
          )
        : const SizedBox.shrink();
  }

  void _onItemTapped(
    BuildContext context,
    WidgetRef ref,
    int index,
    int currentIndex,
  ) {
    if (currentIndex == index) return;

    ref.read(currentIndexProvider.notifier).state = index;

    switch (index) {
      case 0:
        _navigateTo(context, const CourseOverview());
        break;
      case 1:
        _navigateTo(context, const DownloadedCourses());
        break;
      case 2:
        _navigateTo(context, const PinnedCourses());
        break;
      case 3:
        _navigateTo(context, const MyNotifications());
        break;
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(
    IconData icon,
    String label,
    BuildContext context,
    int currentIndex,
    int itemIndex,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _getColorForIcon(context, itemIndex, currentIndex),
      ),
      label: label,
    );
  }
}
