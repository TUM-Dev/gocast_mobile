import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/models/notifications/push_notification.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
      showLeading: false,
      title: title,
      actions: _buildAppBarActions(context, ref),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: pushNotifications.isEmpty &&
                featureNotifications.isEmpty &&
                bannerAlerts.isEmpty
            ? _buildPlaceholder(context)
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  _buildSectionHeader(
                      AppLocalizations.of(context)!.banner_notification),
                  for (var alert in bannerAlerts) _buildBannerAlert(alert),
                  _buildSectionHeader(
                      AppLocalizations.of(context)!.feature_notifications),
                  for (var notification in featureNotifications)
                    _buildFeatureNotification(notification),
                  _buildSectionHeader(
                      AppLocalizations.of(context)!.recent_uploads),
                  for (var notification in pushNotifications)
                    _buildPushNotification(notification),
                ],
              ),
      ),
    );
  }

  Padding _buildPlaceholder(BuildContext context) {
    return Padding(
      padding: AppPadding.sectionPadding,
      child: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  kToolbarHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Text(AppLocalizations.of(context)!
                            .no_notifications_found)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildPushNotification(PushNotification notification) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.notifications_active, color: Colors.green),
        title: Text(
          notification.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.body,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            Text(
              'Received at: ${notification.receivedAt}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        // trailing: const Icon(Icons.arrow_forward_ios, size: 14.0),
      ),
    );
  }

  Widget _buildFeatureNotification(FeatureNotification notification) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading:
            const Icon(Icons.notifications_sharp, color: Colors.blueAccent),
        title: Text(
          notification.title.isEmpty ? "User notification" : notification.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          notification.body,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerAlert(BannerAlert alert) {
    return Card(
      color: alert.warn ? Colors.redAccent : Colors.blueAccent,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          alert.text,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start Date: ${alert.startsAt}\nEnd Date: ${alert.expiresAt}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
