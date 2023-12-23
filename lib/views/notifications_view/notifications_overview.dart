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
    final notificationViewModel =
        ref.read(notificationViewModelProvider.notifier);
    notificationViewModel.fetchFeatureNotifications();
    notificationViewModel.fetchBannerAlerts();
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.read(notificationViewModelProvider);

    final featureNotifications = notificationState.featureNotifications ?? [];
    final bannerAlerts = notificationState.bannerAlerts ?? [];

    return NotificationsScreen(
      title: 'Notifications',
      featureNotifications: featureNotifications,
      bannerAlerts: bannerAlerts,
      onRefresh: () async {
        await ref
            .read(notificationViewModelProvider.notifier)
            .fetchBannerAlerts();
        await ref
            .read(notificationViewModelProvider.notifier)
            .fetchFeatureNotifications();
      },
    );
  }
}
