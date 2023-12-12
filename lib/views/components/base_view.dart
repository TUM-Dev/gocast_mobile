/// Base view for all views
///
/// This view is used to wrap all views in the app. It provides a common
/// scaffold with a navigation bar and a body.
library;

import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/components/custom_bottom_nav_bar.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions; // Add this line

  const BaseView({
    super.key,
    required this.child,
    required this.title,
    this.actions, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0), // Padding for the AppBar
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        titleSpacing: 0.0,
        actions: actions, // Use the actions here
      ),
      body: child,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
