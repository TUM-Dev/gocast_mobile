import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gocast_mobile/views/settings_view/edit_profile_screen_view.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/settings_view/custom_playback_speed_view.dart';
import 'package:gocast_mobile/views/settings_view/playback_speed_picker_view.dart';
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
    _loadThemePreference();
    _loadNotificationPreference();
    _loadUserSettings();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final themePreference = prefs.getString('themeMode') ?? 'light';
    setState(() {
      isDarkMode = themePreference == 'dark';
    });
  }

  Future<void> _saveThemePreference(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', theme);
  }

  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
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

  List<double> getDefaultSpeeds() {
    List<double> defaultSpeeds = [];
    for (int i = 0; i < 14; i++) {
      defaultSpeeds.add((i + 1) * 0.25);
    }
    return defaultSpeeds;
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    var isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: Consumer(
        builder: (context, watch, _) {
          final userState = ref.watch(userViewModelProvider);
          return ListView(
            children: [
              _buildProfileTile(userState),
              const Divider(),
              _buildSectionTitle('Account Settings'),
              _buildEditableListTile('Edit profile', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      updatePreferredName: _updatePreferredNameAPI,
                    ),
                  ),
                );
              }),
              _buildPreferredGreetingTile(),
              _buildSwitchListTile(
                title: 'Push notifications',
                value: isPushNotificationsEnabled,
                onChanged: (value) {
                  setState(() => isPushNotificationsEnabled = value);
                  _saveNotificationPreference(value);
                },
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
                onChanged: (value) =>
                    setState(() => isDownloadOverWifiOnly = value),
              ),
              _buildSectionTitle('Video Playback Speed'),
              _buildPlaybackSpeedsTile(),
              _buildCustomPlaybackSpeedsTile(context),
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
        },
      ),
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

  ListTile _buildPreferredGreetingTile() {
    return ListTile(
      title: const Text('Preferred Greeting'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGreetingRadioOption('Servus'),
          _buildGreetingRadioOption('Moin'),
        ],
      ),
    );
  }

  Widget _buildGreetingRadioOption(String greeting) {
    return Row(
      children: [
        Radio<String>(
          value: greeting,
          groupValue: preferredGreeting,
          onChanged: (String? newValue) {
            if (newValue != null && newValue != preferredGreeting) {
              setState(() {
                preferredGreeting = newValue;
              });
              _updatePreferredGreetingAPI(newValue);
            }
          },
        ),
        Text(greeting),
      ],
    );
  }

  ListTile _buildPlaybackSpeedsTile() {
    return ListTile(
      title: const Text('Playback Speeds'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => showPlaybackSpeedsPicker(
        context,
        selectedPlaybackSpeeds,
        _updateSelectedSpeeds,
      ),
    );
  }

  ListTile _buildCustomPlaybackSpeedsTile(BuildContext context) {
    return ListTile(
      title: const Text('Add Custom Playback Speed'),
      onTap: () {
        showAddCustomSpeedDialog(context, (double customSpeed) {
          _updateSelectedSpeeds(customSpeed, true);
        });
      },
    );
  }

  void _updateSelectedSpeeds(double speed, bool? newValue) {
    setState(() {
      if (newValue == true && !selectedPlaybackSpeeds.contains(speed)) {
        selectedPlaybackSpeeds.add(speed);
      } else if (newValue == false) {
        selectedPlaybackSpeeds.remove(speed);
      }
    });
    _updatePlaybackSpeedsAPI(selectedPlaybackSpeeds);
  }

  void _updatePreferredNameAPI(String name) {
    ref.read(userViewModelProvider.notifier).updateUserSettings([
      UserSetting(type: UserSettingType.PREFERRED_NAME, value: name),
    ]).then((_) {
      // Fetch all settings again to ensure the state is up-to-date
      ref.read(userViewModelProvider.notifier).fetchUserSettings();
    });
  }

  void _updatePreferredGreetingAPI(String greeting) async {
    bool isAuthenticated = await showAuthenticationErrorCard(_scaffoldKey, ref);
    if (isAuthenticated) {
      ref.read(userViewModelProvider.notifier).updateUserSettings([
        UserSetting(type: UserSettingType.GREETING, value: greeting),
      ]).then((_) {
        ref.read(userViewModelProvider.notifier).fetchUserSettings();
      });
    }
  }

  void _updatePlaybackSpeedsAPI(List<double> speeds) async {
    bool isAuthenticated = await showAuthenticationErrorCard(_scaffoldKey, ref);
    if (isAuthenticated) {
      List<Map<String, dynamic>> speedsList = speeds
          .map(
            (speed) => {
              "speed": speed,
              "enabled": true,
            },
          )
          .toList();

      final String speedsJson = jsonEncode(speedsList);

      final UserSetting playbackSpeedSetting = UserSetting(
        type: UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
        value: speedsJson,
      );

      ref
          .read(userViewModelProvider.notifier)
          .updateUserSettings([playbackSpeedSetting]).then((_) {
        ref.read(userViewModelProvider.notifier).fetchUserSettings();
      });
    }
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

  Padding _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  ListTile _buildEditableListTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () async {
        bool isAuthenticated =
            await showAuthenticationErrorCard(_scaffoldKey, ref);
        if (isAuthenticated && mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(
                updatePreferredName: _updatePreferredNameAPI,
              ),
            ),
          );
        }
      },
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
