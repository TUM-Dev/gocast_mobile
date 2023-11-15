import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gocast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0065bd)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text("Hello, iPraktikum! 👋"),
        ),
      ),
    );
  }
}
