import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:gocast_mobile/views/settings_view/playback_speed_settings_view.dart';
import 'package:gocast_mobile/views/settings_view/preferred_greeting_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gocast_mobile/views/settings_view/edit_profile_screen_view.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/settings_view/authentication_error_card_view.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDarkMode = false;
  bool isPushNotificationsEnabled = false;
  bool isDownloadOverWifiOnly = false;
  String preferredGreeting = 'Servus';
  List<double> selectedPlaybackSpeeds = [];
  List<double> customPlaybackSpeeds = [];

  @override
  void initState() {
    super.initState();
    ref.read(userViewModelProvider.notifier).fetchUserSettings();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _loadThemePreference(prefs);
    _loadNotificationPreference(prefs);
    _loadUserSettings();
  }

  Future<void> _loadThemePreference(SharedPreferences prefs) async {
    final themePreference = prefs.getString('themeMode') ?? 'light';
    setState(() {
      isDarkMode = themePreference == 'dark';
    });
  }

  Future<void> _saveThemePreference(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', theme);
  }

  Future<void> _loadNotificationPreference(SharedPreferences prefs) async {
    final notificationPreference = prefs.getBool('notifications') ?? true;
    setState(() {
      isPushNotificationsEnabled = notificationPreference;
    });
  }

  Future<void> _saveNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
  }

  void _loadUserSettings() {
    final userState = ref.read(userViewModelProvider);
    final greetingSetting = userState.userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.GREETING,
      orElse: () => UserSetting(value: 'Default Greeting'),
    );
    preferredGreeting = greetingSetting?.value ?? 'Default Greeting';

    final playbackSpeedSetting = userState.userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
      orElse: () => UserSetting(value: jsonEncode([])),
    );

    if (playbackSpeedSetting != null && playbackSpeedSetting.value.isNotEmpty) {
      try {
        List<dynamic> speedsList = jsonDecode(playbackSpeedSetting.value);
        selectedPlaybackSpeeds.clear(); // Clear the existing list
        customPlaybackSpeeds.clear(); // Clear custom speeds

        for (var item in speedsList) {
          if (item is Map && item['enabled'] == true) {
            double speed = item['speed'] as double;
            selectedPlaybackSpeeds.add(speed); // Add all enabled speeds
            if (!getDefaultSpeeds().contains(speed)) {
              customPlaybackSpeeds.add(speed); // Add to custom if not default
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error parsing playback speeds: $e');
        }
      }
    }
  }

  static List<double> getDefaultSpeeds() {
    return List<double>.generate(14, (i) => (i + 1) * 0.25);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    isDarkMode = themeMode == ThemeMode.dark;
    bool isTablet = MediaQuery.of(context).size.width >= 600 ? true : false;

    if (!isTablet) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: _buildSettingsOverview(),
      );
    } else {
      return Drawer(
        width: MediaQuery.of(context).size.width * 0.45,
        child: _buildSettingsOverview(),
      );
    }
  }

  ListView _buildSettingsOverview() {
    return ListView(
      children: [
        _buildProfileTile(),
        const Divider(),
        _buildSectionTitle('Account Settings'),
        _buildEditableListTile('Edit profile', () {
          // TODO: Navigate to edit profile screen
        }),
        _buildSwitchListTile(
          title: 'Push notifications',
          value: isPushNotificationsEnabled,
          onChanged: (value) =>
              setState(() => isPushNotificationsEnabled = value),
        ),
        _buildSwitchListTile(
          title: 'Dark mode',
          value: isDarkMode,
          onChanged: (value) {
            setState(() => isDarkMode = value);
            ref.read(themeModeProvider.notifier).state =
                value ? ThemeMode.dark : ThemeMode.light;
            _saveThemePreference(value ? 'dark' : 'light');
          },
        ),
        _buildSwitchListTile(
          title: 'Download Over Wi-Fi only',
          value: isDownloadOverWifiOnly,
          onChanged: (value) => setState(() => isDownloadOverWifiOnly = value),
        ),
        _buildLogoutTile(context),
        const Divider(),
        _buildSectionTitle('More'),
        _buildNavigableListTile('About us', () {
          // TODO: Navigate to about us screen
        }),
        _buildNavigableListTile('Privacy policy', () {
          // TODO: Navigate to privacy policy screen
        }),
        _buildNavigableListTile('Terms and conditions', () {
          // TODO: Navigate to terms and conditions screen
        }),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Settings'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  ListTile _buildProfileTile(userState) {
    // Extract settings from userState
    final preferredNameSetting = userState.userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.PREFERRED_NAME,
      orElse: () => UserSetting(value: ''),
    );

    final preferredName = preferredNameSetting?.value ?? '';
    final userName = userState.user?.name ?? 'Guest';

    final greetingSetting = userState.userSettings?.firstWhere(
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
  }) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        inactiveTrackColor: Colors.grey,
      ),
      onTap: () => onChanged(!value),
    );
  }

  ListTile _buildLogoutTile(BuildContext context) {
    return ListTile(
      title: const Text(
        'Log out',
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        ref.read(userViewModelProvider.notifier).logout();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  ListTile _buildNavigableListTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
