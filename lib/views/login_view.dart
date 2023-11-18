import 'package:flutter/material.dart';
import 'package:gocast_mobile/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> handleSSOLogin(BuildContext context) async {
      // Call the SSO authentication function from /base/api/auth
      await ref.read(userViewModel).ssoAuth(context);
      // Navigate to the home screen after successful authentication
      if (ref.read(userViewModel).current.value.user != null) {
        // ignore: use_build_context_synchronously
        await Navigator.pushNamed(context, '/welcome');
      }
    }

    Future<void> handleBasicLogin(BuildContext context) async {
      // Call the basic authentication function from /base/api/auth
      await ref
          .read(userViewModel)
          .basicAuth(usernameController.text, passwordController.text)
          .then(
            (value) => {
              if (ref.read(userViewModel).current.value.user != null)
                {Navigator.pushNamed(context, '/welcome')},
            },
          );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ref.read(userViewModel).current.value.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 32),
                      Image.asset(
                        'assets/images/logos/tum-logo-blue.png',
                        fit: BoxFit.contain,
                        height: 64,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () => handleSSOLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Sign in using TUM SSO',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'User',
                          labelStyle: const TextStyle(color: Colors.blue),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.blue),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () => handleBasicLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
