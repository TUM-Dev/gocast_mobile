import 'package:flutter/material.dart';
import 'package:gocast_mobile/viewModels/user_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({required this.userViewModel, super.key});

  final UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to GoCast'),
      ),
      body: Center(
        child: Text(
          'Servus, ${userViewModel.current.user?.name ?? 'Guest'}!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
