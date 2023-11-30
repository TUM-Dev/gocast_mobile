import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/base_view.dart';


class NotificationsScreen extends ConsumerWidget {
  NotificationsScreen({super.key});

  final Map<String, List<String>> notifications = {
    'Today': [
      'Lineare Algebra für Informatik is live now!',
      'Functional Programming and verification is live now!',
    ],
    'Yesterday': [
      'Lineare Algebra für Informatik is live now!',
      'Functional Programming and verification is live now!',
    ],
    'November 25': [
      'Lineare Algebra für Informatik is live now!',
      'Functional Programming and verification is live now!',
    ],
    // Add more data here
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(

      title: 'Notifications',
      child: ListView.builder(
        itemCount: notifications.keys.length,
        itemBuilder: (context, index) {
          String key = notifications.keys.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  key,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...notifications[key]!.map(
                (notification) => ListTile(
                  title: Text(notification),
                  trailing: const Text('06:30'),
                ),
              ),
            ],
          );
        },
      ),

    );
  }
}
