import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/main.dart';

import '../login_view/internal_login_view.dart';
import '../utils/constants.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  Future<void> handleSSOLogin(
    BuildContext context,
    WidgetRef ref,
    TextEditingController usernameController,
    TextEditingController passwordController,
  ) async {
    // Call the SSO authentication function from /base/api/auth
    await ref.read(userViewModel).ssoAuth(context);
    // Navigate to the home screen after successful authentication
    if (ref.read(userViewModel).current.value.user != null) {
      // ignore: use_build_context_synchronously
      await Navigator.pushNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              Image.asset(
                'assets/images/streamicon.png',
                width: 150.0,
                height: 150.0,
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Gocast',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Here's a good place for a brief overview of the app or its key features.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _indicatorDot(true, context),
                  _indicatorDot(false, context),
                  _indicatorDot(false, context),
                ],
              ),
              // Image and Text widgets remain unchanged
              const Spacer(),
              _buildLoginButton(
                context,
                ref,
                usernameController,
                passwordController,
              ),
              const SizedBox(height: 12),
              _buildContinueWithoutButton(),
              const SizedBox(height: 12),
              _buildInternalAccountLink(context),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    WidgetRef ref,
    TextEditingController usernameController,
    TextEditingController passwordController,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonVerticalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: const Text('TUM Login', style: TextStyle(fontSize: 18)),
      onPressed: () =>
          handleSSOLogin(context, ref, usernameController, passwordController),
    );
  }

  Widget _buildContinueWithoutButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blue[900] ?? Colors.blue),
        foregroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonVerticalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: const Text('Continue without', style: TextStyle(fontSize: 18)),
      onPressed: () {},
    );
  }

  Widget _buildInternalAccountLink(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InternalLoginScreen()),
      ),
      child: const Center(
        child: Text('Use an internal account'),
      ),
    );
  }

  Widget _indicatorDot(bool isActive, BuildContext context) {
    return Container(
      height: AppSizes.indicatorDotSize, // Defined in your constants
      width: AppSizes.indicatorDotSize, // Defined in your constants
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.secondary
            : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
