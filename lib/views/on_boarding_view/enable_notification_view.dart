import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EnableNotificationscreen extends StatelessWidget {
  const EnableNotificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              Image.asset(
                'assets/images/notification.png',
                width: 200.0,
                height: 200.0,
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.turn_on_notifications,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.notifications_description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 48),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.enable_notifications,
                  style: const TextStyle(fontSize: 18),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.skip,
                  style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                ),
                onPressed: () {},
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
