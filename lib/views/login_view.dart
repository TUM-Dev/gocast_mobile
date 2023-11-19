/*import 'package:flutter/material.dart';
import 'package:gocast_mobile/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

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

  Future<void> handleBasicLogin(
    BuildContext context,
    WidgetRef ref,
    TextEditingController usernameController,
    TextEditingController passwordController,
  ) async {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
                      const LogoImage(),
                      const SizedBox(height: 32),
                      LoginButton(
                        onPressed: () => handleSSOLogin(
                          context,
                          ref,
                          usernameController,
                          passwordController,
                        ),
                        label: 'Sign in using TUM SSO',
                        key: const Key('basicSSOButton'),
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
                      LoginButton(
                        onPressed: () => handleBasicLogin(
                          context,
                          ref,
                          usernameController,
                          passwordController,
                        ),
                        label: 'Login',
                        key: const Key('basicLoginButton'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logos/tum-logo-blue.png',
      fit: BoxFit.contain,
      height: 64,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    required Key key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
*/
