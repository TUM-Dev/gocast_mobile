import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/main.dart';
import 'package:gocast_mobile/views/login_view/internal_login_view.dart';
import 'package:gocast_mobile/views/utils/constants.dart';
import 'package:gocast_mobile/views/utils/globals.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(usernameControllerProvider);
    ref.watch(passwordControllerProvider);

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
              _buildWelcomeText(),
              const SizedBox(height: 8),
              _buildOverviewText(),
              const SizedBox(height: 48),
              const Spacer(),
              _buildLoginButton(context, ref),
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

  Widget _buildWelcomeText() {
    return const Text(
      'Welcome to Gocast',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildOverviewText() {
    return const Text(
      "Here's a good place for a brief overview of the app or its key features.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.black54),
    );
  }

  Widget _buildLoginButton(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(userViewModel).isLoading;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.buttonVerticalPadding,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      child: isLoading.value
          ? const SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text('TUM Login', style: TextStyle(fontSize: 18)),
      onPressed: () => handleSSOLogin(context, ref),
    );
  }

  Widget _buildContinueWithoutButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blue[900] ?? Colors.blue),
        foregroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.buttonVerticalPadding,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
      child: const Center(child: Text('Use an internal account')),
    );
  }

  Future<void> handleSSOLogin(BuildContext context, WidgetRef ref) async {
    // Call the SSO authentication function from /base/api/auth
    await ref.read(userViewModel).ssoAuth(context).then(
          (value) => {
            if (ref.read(userViewModel).current.value.user != null)
              {Navigator.pushNamed(context, '/courses')}
            else
              {Navigator.pushNamed(context, '/home')},
          },
        );
  }
}
