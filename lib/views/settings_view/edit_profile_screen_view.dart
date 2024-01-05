import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final Function(String) updatePreferredName;

  const EditProfileScreen({super.key, required this.updatePreferredName});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
            const Row(
              children: [
                Text(
                  'You can change this once ',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'every three months.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                  String preferredName = preferredNameController.text;
                  widget.updatePreferredName(preferredName);
                  setState(() {
                    infoText = 'Preferred name saved: $preferredName';
                    isError = false;
                  });
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
}
