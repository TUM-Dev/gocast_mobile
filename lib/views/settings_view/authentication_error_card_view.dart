import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: Text(AppLocalizations.of(context)!.auth_required_title),
          content: Text(AppLocalizations.of(context)!.auth_required_message),
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
