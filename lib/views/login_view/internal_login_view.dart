import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/globals.dart';

/// Internal login screen view.
///
/// This screen is used to login with a username and password.
/// It contains a welcome text, two text fields for username and password,
/// a forgot password button and a login button.
/// The login button calls the basic authentication function from /base/api/auth
/// The forgot password button does nothing for now.
class InternalLoginScreen extends ConsumerStatefulWidget {
  const InternalLoginScreen({super.key});

  @override
  InternalLoginScreenState createState() => InternalLoginScreenState();
}

class InternalLoginScreenState extends ConsumerState<InternalLoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWelcomeText(),
                const SizedBox(height: 48),
                _buildTextField(
                  'Username',
                  'e.g. go42tum / example@tum.de',
                  usernameController,
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  'Password',
                  'Enter your password',
                  passwordController,
                  obscureText: true,
                ),
                _buildForgotPasswordButton(),
                const SizedBox(height: 24),
                _buildLoginButton(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'Welcome To GoCast!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.blue[900],
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hintText,
    TextEditingController controller, {
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        // TODO: Forgot Password action
      },
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        final userStateNotifier = ref.read(userViewModelProvider.notifier);
        userStateNotifier.handleBasicLogin(
          usernameController.text,
          passwordController.text,
        );
        if ( userState.user != null) {
          ref.read(settingViewModelProvider.notifier).fetchUserSettings();
        } else {
          userState.copyWith(isLoading: false);
        }
      },
      child: userState.isLoading
          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : const Text('Login', style: TextStyle(fontSize: 18)),
    );
  }
}
