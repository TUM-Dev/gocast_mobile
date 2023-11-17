import 'package:flutter/material.dart';
import 'package:gocast_mobile/viewModels/user_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({required this.userViewModel, super.key});

  final UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: userViewModel.logout,
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
