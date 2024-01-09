import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';

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
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.grey), // Default text style
                children: [
                  TextSpan(text: 'You can change this '),
                  TextSpan(
                    text: 'once every three months.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
    bool success = await ref
        .read(userViewModelProvider.notifier)
        .updatePreferredName(name);
    if (success) {
      setState(() {
        infoText = 'Preferred name saved: $name';
        isError = false;
      });
    } else {
      setState(() {
        infoText = 'Error updating preferred name';
        isError = true;
      });
    }
  }
}
