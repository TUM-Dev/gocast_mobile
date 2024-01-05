import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gocast_mobile/views/settings_view/edit_profile_screen_view.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool isDarkMode = false;
  bool isPushNotificationsEnabled = false;
  bool isDownloadOverWifiOnly = false;
  String preferredGreeting = 'Servus';
  List<double> selectedPlaybackSpeeds = [];

  @override
  void initState() {
    super.initState();
    ref.read(userViewModelProvider.notifier).fetchUserSettings();
    _loadThemePreference();
    _loadNotificationPreference();
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

  @override
  Widget build(BuildContext context) {
    // Update isDarkMode based on the provider
    final themeMode = ref.watch(themeModeProvider);
    isDarkMode = themeMode == ThemeMode.dark;
    final userState = ref.watch(userViewModelProvider);

    final currentGreeting = userState.userSettings
            ?.firstWhere(
              (setting) => setting.type == UserSettingType.GREETING,
              orElse: () => UserSetting(value: 'Default Greeting'),
            )
            .value ??
        'Default Greeting';

    if (preferredGreeting != currentGreeting) {
      setState(() {
        preferredGreeting = currentGreeting;
      });
    }

    selectedPlaybackSpeeds = [1.0];

    final playbackSpeedSetting = userState.userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
      orElse: () => UserSetting(value: 'values'),
    );

    if (playbackSpeedSetting != null && playbackSpeedSetting.value.isNotEmpty) {
      try {
        // Decode the JSON string
        List<dynamic> speedsList = jsonDecode(playbackSpeedSetting.value);
        if (kDebugMode) {
          print('Decoded speeds list: $speedsList');
        }
        selectedPlaybackSpeeds = speedsList
            .where((item) => item is Map && item['enabled'] == true)
            .map((item) => item['speed'] as double)
            .toList();
        if (kDebugMode) {
          print('Selected playbacks: $selectedPlaybackSpeeds');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error parsing playback speeds: $e');
        }
      }
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        children: [
          _buildProfileTile(),
          const Divider(),
          _buildSectionTitle('Account Settings'),
          _buildEditableListTile('Edit profile', () {}),
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
          _buildCustomPlaybackSpeedsTile(),
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
      onTap: () => _showPlaybackSpeedsPicker(),
    );
  }

  ListTile _buildCustomPlaybackSpeedsTile() {
    return ListTile(
      title: const Text('Add Custom Playback Speed'),
      onTap: () => _showAddCustomSpeedDialog(),
    );
  }

  void _showPlaybackSpeedsPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 14,
                itemBuilder: (context, index) {
                  final double speed = (index + 1) * 0.25;
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                      child: Text('${speed}x'),
                    ),
                    trailing: selectedPlaybackSpeeds.contains(speed)
                        ? const Icon(Icons.check)
                        : const SizedBox(),
                    onTap: () {
                      bool isSelected = selectedPlaybackSpeeds.contains(speed);
                      _updateSelectedSpeeds(speed, !isSelected);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddCustomSpeedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double customSpeed = 1.0;
        return Dialog(
          child: Material(
            type: MaterialType.card,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Add Custom Speed',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter speed (e.g., 1.7)',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      customSpeed = double.tryParse(value) ?? 1.0;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Add'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _updateSelectedSpeeds(customSpeed, true);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
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

  void _updatePreferredGreetingAPI(String greeting) {
    ref.read(userViewModelProvider.notifier).updateUserSettings([
      UserSetting(type: UserSettingType.GREETING, value: greeting),
    ]);
  }

  void _updatePlaybackSpeedsAPI(List<double> speeds) {
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
        .updateUserSettings([playbackSpeedSetting]);
  }

  ListTile _buildProfileTile() {
    final greeting = ref
        .watch(userViewModelProvider)
        .userSettings
        ?.firstWhere(
          (setting) => setting.type == UserSettingType.GREETING,
          orElse: () => UserSetting(value: 'Hi'),
        )
        .value;

    final userName = ref.read(userViewModelProvider).user?.name ?? 'Guest';

    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile_temp.png'),
      ),
      title: Text('$greeting, $userName'),
      onTap: () {
        // TODO: Navigate to profile edit screen
      },
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
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditProfileScreen(),
          ),
        );
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
