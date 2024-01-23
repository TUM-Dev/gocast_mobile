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
  void initState() {
    super.initState();
    preferredNameController.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    preferredNameController.removeListener(_updateCharacterCount);
    preferredNameController.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding:
              isLandscape ? const EdgeInsets.only(top: 16.0) : EdgeInsets.zero,
          child: const Text('Edit Profile'),
        ),
      ),
      body: Padding(
        padding: isLandscape
            ? const EdgeInsets.only(left: 25, right: 55)
            : EdgeInsets.zero,
        child: SingleChildScrollView(
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
                maxLength: 50,
                decoration: InputDecoration(
                  hintText: 'Enter your preferred name',
                  border: const OutlineInputBorder(),
                  counterText: '${preferredNameController.text.length}/80',
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.scrim.withOpacity(0.50),
                  ),
                  children: const [
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
                onPressed: () => _onSaveButtonPressed(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Save'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                infoText,
                style: TextStyle(
                  color: isError
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSaveButtonPressed() {
    if (mounted) {
      if (preferredNameController.text.trim().isNotEmpty) {
        _updatePreferredName(preferredNameController.text);
      } else {
        setState(() {
          infoText = 'Please enter a preferred name';
          isError = true;
        });
      }
    }
  }

  Future<void> _updatePreferredName(String name) async {
    try {
      bool success = await ref
          .read(settingViewModelProvider.notifier)
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
    } catch (e) {
      setState(() {
        infoText = 'An error occurred';
        isError = true;
      });
    }
  }
}
