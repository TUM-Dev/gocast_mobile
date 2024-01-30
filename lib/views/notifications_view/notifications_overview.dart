import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'notifications_screen_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MyNotifications extends ConsumerStatefulWidget {
  const MyNotifications({super.key});

  @override
  MyNotificationsState createState() => MyNotificationsState();
}

class MyNotificationsState extends ConsumerState<MyNotifications> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref
          .read(notificationViewModelProvider.notifier)
          .fetchFeatureNotifications();
      await ref
          .read(notificationViewModelProvider.notifier)
          .fetchBannerAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationViewModelProvider);

    final pushNotifications = notificationState.pushNotifications ?? [];
    final featureNotifications = notificationState.featureNotifications ?? [];
    final bannerAlerts = notificationState.bannerAlerts ?? [];

    return NotificationsScreen(
      title: AppLocalizations.of(context)!.notifications,
      pushNotifications: pushNotifications,
      featureNotifications: featureNotifications,
      bannerAlerts: bannerAlerts,
      onRefresh: _refreshNotifications,
    );
  }

  Future<void> _refreshNotifications() async {
    await ref.read(notificationViewModelProvider.notifier).fetchBannerAlerts();
    await ref
        .read(notificationViewModelProvider.notifier)
        .fetchFeatureNotifications();
  }
}
