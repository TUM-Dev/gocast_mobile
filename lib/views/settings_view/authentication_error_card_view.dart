import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';

Future<bool> showAuthenticationErrorCard(
    GlobalKey<ScaffoldState> scaffoldKey, WidgetRef ref) async {
  final userState = ref.read(userViewModelProvider);
  bool isAuthenticated = userState.user != null;

  if (!isAuthenticated && scaffoldKey.currentContext != null) {
    await showDialog(
      context: scaffoldKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
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
