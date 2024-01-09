import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';

Future<bool> showAuthenticationErrorCard(
  BuildContext context,
  WidgetRef ref,
) async {
  final userState = ref.read(userViewModelProvider);
  bool isAuthenticated = userState.user != null;

  if (!isAuthenticated) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text('Authentication Required'),
          content: const Text('Please log in to access this feature.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
  return isAuthenticated;
}
