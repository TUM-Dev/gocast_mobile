import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/models/notifications/push_notification.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

class NotificationsScreen extends ConsumerWidget {
  final String title;
  final List<PushNotification> pushNotifications;
  final List<FeatureNotification> featureNotifications;
  final List<BannerAlert> bannerAlerts;
  final Future<void> Function() onRefresh;

  const NotificationsScreen({
    super.key,
    required this.title,
    required this.pushNotifications,
    required this.featureNotifications,
    required this.bannerAlerts,
    required this.onRefresh,
  });

  // A basic functioning view that supports all notification related functions
  // TODO: Needs to be adapted to figma design
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
      title: title,
      actions: _buildAppBarActions(context, ref),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: (pushNotifications.isEmpty &&
                featureNotifications.isEmpty &&
                bannerAlerts.isEmpty)
            ? _buildPlaceholder()
            : ListView.separated(
                itemCount: pushNotifications.length +
                    featureNotifications.length +
                    bannerAlerts.length +
                    2, // Add 2 for separators
                itemBuilder: (context, index) {
                  if (index < pushNotifications.length) {
                    return _buildPushNotificationWidget(index);
                  } else if (index == pushNotifications.length ||
                      index ==
                          pushNotifications.length +
                              featureNotifications.length +
                              1) {
                    return const Divider(
                      color: Colors.grey,
                    ); // This is the separator
                  } else if (index <
                      pushNotifications.length +
                          featureNotifications.length +
                          1) {
                    int featureIndex = index - pushNotifications.length - 1;
                    return ListTile(
                      title: Text(featureNotifications[featureIndex].title),
                      subtitle: Text(featureNotifications[featureIndex].body),
                    );
                  } else {
                    int alertIndex = index -
                        pushNotifications.length -
                        featureNotifications.length -
                        2;
                    return ListTile(
                      title: Text(bannerAlerts[alertIndex].text),
                      subtitle: Text(
                        'Starts at: ${bannerAlerts[alertIndex].startsAt}\nExpires at: ${bannerAlerts[alertIndex].expiresAt}',
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.grey), // This is the separator
              ),
      ),
    );
  }

  Padding _buildPlaceholder() {
    return const Padding(
      padding: AppPadding.sectionPadding,
      child: Center(child: Text('No Notifications found.')),
    );
  }

  //TODO export functionality
  List<Widget> _buildAppBarActions(BuildContext context, WidgetRef ref) {
    return [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        ),
      ),
    ];
  }

/*
  Widget _buildFeatureNotificationsListView() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          /*final course = featureNotifications[index];
          return CourseCard(
            title: course.name,
            subtitle: course.slug,
            path: 'assets/images/course2.png',
            live: course.streams.any((stream) => stream.liveNow),
          );*/
          return const Text("This will be the feature notifications");
        },
        childCount: featureNotifications.length,
      ),
    );
  }

  //TODO do we need to check dates ourselves?
  Widget _buildBannerAlertsListView() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return const Text("This will be the  Banner Alerts");
        },
        childCount: bannerAlerts.length,
      ),
    );
  }
*/

  Widget _buildPushNotificationWidget(int index) {
    // Replace this with your actual widget building code for push notifications
    return ListTile(
      title: Text(pushNotifications[index].title),
      subtitle: Text(pushNotifications[index].body),
      trailing: Text(pushNotifications[index].receivedAt.toString()),
    );
  }
}
