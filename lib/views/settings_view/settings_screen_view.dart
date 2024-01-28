import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:gocast_mobile/views/settings_view/playback_speed_settings_view.dart';
import 'package:gocast_mobile/views/settings_view/preferred_greeting_view.dart';
import 'package:gocast_mobile/views/settings_view/edit_profile_screen_view.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/settings_view/authentication_error_card_view.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

bool _isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= 600;
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(settingViewModelProvider.notifier).fetchUserSettings(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    final settingState = ref.watch(settingViewModelProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: Consumer(
        builder: (context, watch, _) {
          return ListView(
            children: [
              _buildProfileTile(userState),
              const Divider(),
              _buildSectionTitle('Account Settings'),
              _buildEditableListTile('Edit profile', () async {
                bool isAuthenticated =
                    await showAuthenticationErrorCard(context, ref);
                if (isAuthenticated && mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                }
              }),
              const PreferredGreetingView(),
              _buildSwitchListTile(
                title: 'Push notifications',
                value: settingState.isPushNotificationsEnabled,
                onChanged: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveNotificationPreference(value);
                },
                ref: ref,
              ),
              _buildThemeSelectionTile(context, ref),
              _buildSwitchListTile(
                title: 'Download Over Wi-Fi only',
                value: settingState.isDownloadWithWifiOnly,
                onChanged: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveDownloadWifiOnlyPreference(value);
                },
                ref: ref,
              ),
              _buildSectionTitle('Video Playback Speed'),
              const PlaybackSpeedSettings(),
              _buildLogoutTile(context),
              const Divider(),
              _buildSectionTitle('More'),
              _buildNavigableListTile('About us', ""),
              _buildNavigableListTile(
                'Privacy policy',
                "https://live.rbg.tum.de/privacy",
              ),
              _buildNavigableListTile(
                'Terms and conditions',
                "https://live.rbg.tum.de/imprint",
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Settings'),
      leading: IconButton(
        icon: !_isTablet(context)
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  ListTile _buildThemeSelectionTile(BuildContext context, WidgetRef ref) {
    // Get the current theme setting from the state
    final settingState = ref.watch(settingViewModelProvider);

    String themeModeText;
    if (settingState.isDarkMode) {
      themeModeText = 'Dark Mode';
    } else if (settingState.isLightMode) {
      themeModeText = 'Light Mode';
    } else {
      themeModeText = 'System Default';
    }

    return ListTile(
      title: const Text('Choose Theme'),
      subtitle: Text(themeModeText),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showThemeSelectionSheet(context, ref),
    );
  }

  void _showThemeSelectionSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: const Text('System Default'),
                onTap: () {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveThemePreference('system', ref);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Dark Mode'),
                onTap: () {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveThemePreference('dark', ref);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Light Mode'),
                onTap: () {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveThemePreference('light', ref);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile _buildProfileTile(userState) {
    final settingState = ref.watch(settingViewModelProvider);
    final preferredNameSetting = settingState.userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.PREFERRED_NAME,
      orElse: () => UserSetting(value: ''),
    );
    final preferredName = preferredNameSetting?.value ?? '';
    final userName = userState.user?.name ?? 'Guest';

    final greetingSetting = settingState.userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.GREETING,
      orElse: () => UserSetting(value: 'Hi'),
    );

    final preferredGreeting = greetingSetting?.value ?? 'Hi';
    String displayName = preferredName.isNotEmpty ? preferredName : userName;

    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile_temp.png'),
      ),
      title: Text('$preferredGreeting, $displayName'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  ListTile _buildEditableListTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  ListTile _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required WidgetRef ref,
  }) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        inactiveTrackColor: Theme.of(context).colorScheme.background,
      ),
      onTap: () => onChanged(!value),
    );
  }

  ListTile _buildLogoutTile(BuildContext context) {
    return ListTile(
      title: Text(
        'Log out',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      onTap: () => _showLogoutDialog(context),
    );
  }

  void _showLogoutDialog(BuildContext context) async {
    // Capture the Navigator state before the async gap
    final NavigatorState navigator = Navigator.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Would you like to delete all your downloads?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              // User chooses not to delete downloads
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              // User chooses to delete downloads
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
    if (!mounted) return;
    if (result == true) {
      // User decided to delete all downloads
      await ref.read(downloadViewModelProvider.notifier).deleteAllDownloads();
    }
    // Proceed with logout
    ref.read(userViewModelProvider.notifier).logout();
    // Use the captured Navigator state
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  ListTile _buildNavigableListTile(String title, String redirectTo) {
    final Uri url = Uri.parse(redirectTo);

    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }
}
