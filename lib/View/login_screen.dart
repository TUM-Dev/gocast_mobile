import 'package:flutter/material.dart';
import 'internallogin_screen.dart';
import 'package:gocast_mobile/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Loginscreen extends ConsumerWidget {
  const Loginscreen({super.key});
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
      appBar: AppBar(

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              Text(
                'Welcome To GoCast!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue[900], // Replace with the exact color
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 36),
              Image.asset(
                'assets/images/streamicon.png',
                width: 150.0,
                height: 150.0,
              ),
              const SizedBox(height: 36),
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
                onPressed: () => handleSSOLogin(context, ref, usernameController,
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
                child: const Text('Use an Internal Account',
                    style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InternalloginScreen(),
                    ),
                  );
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
