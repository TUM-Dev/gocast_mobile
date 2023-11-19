/*
import 'package:flutter/material.dart';
import 'package:gocast_mobile/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to GoCast'),
        ),
        body: Center(
          child: Text(
            'Servus, ${ref.read(userViewModel).current.value.user?.name ?? 'Guest'}!',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
*/