import 'package:flutter/material.dart';
import 'package:gocast_mobile/utils/theme.dart';
import 'package:gocast_mobile/views/components/custom_bottom_nav_bar.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool showLeading;
  final PreferredSizeWidget? customAppBar;
  final Widget? bottomNavigationBar;

  const BaseView({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.showLeading = true,
    this.customAppBar,
    this.bottomNavigationBar = const CustomBottomNavBar(),
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppBar ??
          (title != null
              ? AppBar(
                  automaticallyImplyLeading: showLeading,
                  title: Text(title!),
                  actions: actions,
                )
              : null),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
