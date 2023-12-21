import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/components/base_view.dart';

import '../../utils/constants.dart';
import '../settings_view/settings_screen_view.dart';

class NotificationsScreen extends ConsumerWidget {
  final String title;
  final List<FeatureNotification> featureNotifications;
  final List<BannerAlert> bannerAlerts;
  final Future<void> Function() onRefresh;

  NotificationsScreen({
    super.key,
    required this.title,
    required this.featureNotifications,
    required this.bannerAlerts,
    required this.onRefresh,
  });

  final Map<String, List<String>> pushNotifications = {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
      title: title,
      actions: _buildAppBarActions(context, ref),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        color: Colors.blue,
        // Indicator color
        backgroundColor: Colors.white,
        // Background color of the indicator
        strokeWidth: 2.0,
        // Thickness of the indicator circle
        displacement: 20.0,
        // How far to pull down to trigger refresh
        child: CustomScrollView(
          slivers: [
            featureNotifications.isEmpty && bannerAlerts.isEmpty
                ? SliverFillRemaining(
                    child: _buildPlaceholder(),
                  )
                : SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      _buildFeatureNotificationsListView(),
                      _buildBannerAlertsListView(),
                    ]),
                  ),
          ],
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
          final course = featureNotifications[index];
          /*return CourseCard(
            title: course.name,
            subtitle: course.slug,
            path: 'assets/images/course2.png',
            live: course.streams.any((stream) => stream.liveNow),
          );*/
          return Text("This will be the feature notifications");
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
          final course = bannerAlerts[index];
          return Text("This will be the  Banner Alerts");
        },
        childCount: bannerAlerts.length,
      ),
    );
  }
}
