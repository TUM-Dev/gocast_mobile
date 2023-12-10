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
      /*title: Text('Notifications',
              style: TextStyle(color: Colors.blue))
          .toString(),*/
      child: ListView.builder(
        itemCount: notifications.keys.length,
        itemBuilder: (context, index) {
          String key = notifications.keys.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  key,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  //style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...notifications[key]!.map(
                    (notification) => Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15),
                  padding: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Light grey background color
                    borderRadius:
                    BorderRadius.circular(8.0), // Optional: rounded corners
                  ),
                  child: ListTile(
                    title: Text(notification),
                    trailing: const Text('06:30'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}