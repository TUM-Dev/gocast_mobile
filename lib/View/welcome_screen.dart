import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'internallogin_screen.dart';
import 'package:gocast_mobile/main.dart';

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
          padding: const EdgeInsets.all(16.0),
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
                  _indicatorDot(true),
                  _indicatorDot(false),
                  _indicatorDot(false),
                ],
              ),
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
                child: const Text(
                  'TUM Login',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () => handleSSOLogin(
                  context,
                  ref,
                  usernameController,
                  passwordController,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  foregroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Continue without',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InternalloginScreen(),
                    ),
                  );
                  // Use the route name for your different screen
                },
                child:  Center(
                  child: Text(
                    'Use an internal account', // Your text
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue[900],
                      color: Colors.blue[900], // Use theme color for consistency
                      fontSize: 16, // Your preferred font size
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _indicatorDot(bool isActive) {
    return Container(
      height: 10.0,
      width: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
