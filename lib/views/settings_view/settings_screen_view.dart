import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/main.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool isDarkMode = false;
  bool isPushNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
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
            onChanged: (value) => setState(() => isDarkMode = value),
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

  ListTile _buildProfileTile() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile_temp.png'),
      ),
      title: Text(ref.read(userViewModel).current.value.user?.name ?? 'Guest'),
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
      title: const Text('Log out'),
      onTap: () {
        ref.read(userViewModel).logout();
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
