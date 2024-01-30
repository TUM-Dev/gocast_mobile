import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
          child:  Text(AppLocalizations.of(context)!.edit_profile),
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
               Text(
                AppLocalizations.of(context)!.preferred_name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: preferredNameController,
                maxLength: 50,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enter_preferred_name,
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
                  children:  [
                    TextSpan(
                      text: AppLocalizations.of(context)!.name_change_limitation,
                      style: const TextStyle(
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
                onPressed: () => _onSaveButtonPressed(context),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(AppLocalizations.of(context)!.save),
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

  void _onSaveButtonPressed(BuildContext context) {
    if (mounted) {
      if (preferredNameController.text.trim().isNotEmpty) {
        _updatePreferredName(preferredNameController.text);
      } else {
        _showErrorDialog(AppLocalizations.of(context)!.enter_preferred_name);
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
          infoText = AppLocalizations.of(context)!.preferred_name_saved(name);
          isError = false;
        });
      } else {
        _showErrorDialog('3 months');
      }
    } catch (e) {
      _showErrorDialog('An error occurred');
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text("Error"),
          content: Text(errorMessage== '3 months' ? AppLocalizations.of(context)!.name_change_limitation : errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
