import 'package:flutter/material.dart';
import 'package:gocast_mobile/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(userViewModel).logout(),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'TODO: Implement main views',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
