import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';

import 'notifications_screen_view.dart';

class MyNotifications extends ConsumerStatefulWidget {
  const MyNotifications({super.key});

  @override
  MyNotificationsState createState() => MyNotificationsState();
}

class MyNotificationsState extends ConsumerState<MyNotifications> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    Future.delayed(Duration.zero, () async {
      try {
        await ref
            .read(userViewModelProvider.notifier)
            .fetchFeatureNotifications();
        await ref.read(userViewModelProvider.notifier).fetchBannerAlerts();
      } catch (e) {
        // Handle errors if needed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final featureNotifications =
        ref.watch(userViewModelProvider).featureNotifications ?? [];
    final bannerAlerts = ref.watch(userViewModelProvider).bannerAlerts ?? [];

    return NotificationsScreen(
      title: 'Notifications',
      featureNotifications: featureNotifications,
      bannerAlerts: bannerAlerts,
      onRefresh: () async {
        await ref.read(userViewModelProvider.notifier).fetchUserCourses();
      },
    );
  }
}
