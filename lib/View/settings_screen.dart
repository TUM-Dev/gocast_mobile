import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/View/login_screen.dart';
import 'package:gocast_mobile/main.dart';

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
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('path_to_your_profile_image'),
            ),
            title: const Text('Max Mustermann'),
            onTap: () {
              // Navigate to profile edit screen
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            title: const Text('Edit profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to edit profile screen
            },
          ),
          ListTile(
            title: const Text('Push notifications'),
            trailing: CupertinoSwitch(
              value: isPushNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  isPushNotificationsEnabled = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                isPushNotificationsEnabled = !isPushNotificationsEnabled;
              });
            },
          ),
          ListTile(
            title: const Text('Dark mode'),
            trailing: CupertinoSwitch(
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              // Handle log out
              ref.read(userViewModel).logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Loginscreen()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'More',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Adjust the color to match your design
              ),
            ),
          ),
          ListTile(
            title: const Text('About us'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to about us screen
            },
          ),
          ListTile(
            title: const Text('Privacy policy'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to privacy policy screen
            },
          ),
          ListTile(
            title: const Text('Terms and conditions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to terms and conditions screen
            },
          ),
        ],
      ),
    );
  }
}
