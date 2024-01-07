import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController preferredNameController = TextEditingController();
  String infoText = '';
  bool isError = false;

  @override
  void dispose() {
    preferredNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferred Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: preferredNameController,
              decoration: const InputDecoration(
                hintText: 'Enter your preferred name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You can change this once every three months.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                if (preferredNameController.text.isNotEmpty) {
                  _updatePreferredName(preferredNameController.text);
                } else {
                  setState(() {
                    infoText = 'Please enter a preferred name';
                    isError = true;
                  });
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Save'),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              infoText,
              style: TextStyle(
                color: isError ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updatePreferredName(String name) async {
    try {
      await ref.read(userViewModelProvider.notifier).updateUserSettings([
        UserSetting(type: UserSettingType.PREFERRED_NAME, value: name),
      ]);
      await ref.read(userViewModelProvider.notifier).fetchUserSettings();
      setState(() {
        infoText = 'Preferred name saved: $name';
        isError = false;
      });
    } catch (e) {
      setState(() {
        infoText = 'Error updating preferred name';
        isError = true;
      });
    }
  }
}
