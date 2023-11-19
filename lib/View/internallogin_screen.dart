import 'package:flutter/material.dart';

class InternalloginScreen extends StatelessWidget {
  const InternalloginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome To GoCast!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue[900], // Replace with the exact color
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Username',
                style: TextStyle(
                  color: Colors.grey[800], // Replace with the exact color
                  fontSize: 16,
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'e.g. go42tum / example@tum.de',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                  ), // Replace with the exact color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                    ), // Replace with the exact color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                    ), // Replace with the exact color
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Password',
                style: TextStyle(
                  color: Colors.grey[800], // Replace with the exact color
                  fontSize: 16,
                ),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                  ), // Replace with the exact color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                    ), // Replace with the exact color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                    ), // Replace with the exact color
                  ),
                  suffixIcon: Icon(Icons.visibility_off,
                      color: Colors.grey,
                  ), // Replace with the exact color
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Forgot Password action
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Colors.blue,
                  ), // Replace with the exact color
                ),
              ),
              const SizedBox(height: 24),
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
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
