import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/components/custom_bottom_nav_bar.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;  // Add this line

  const BaseView({
    super.key,
    required this.child,
    required this.title,
    this.actions,  // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,  // Use the actions here
      ),
      body: child,
      bottomNavigationBar:const CustomBottomNavBar(),

    );
  }
}
