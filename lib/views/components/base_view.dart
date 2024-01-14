import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/components/custom_bottom_nav_bar.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool showLeading;
  final PreferredSizeWidget? customAppBar;
  final Widget? bottomNavigationBar;
  final Widget? settingsHamburgerMenu;

  const BaseView({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.showLeading = true,
    this.customAppBar,
    this.bottomNavigationBar = const CustomBottomNavBar(),
    this.settingsHamburgerMenu = const SettingsScreen(),
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    //bool isTablet = MediaQuery.of(context).size.width >= 600 ? true : false;

    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar ??
          (title != null
              ? AppBar(
                  automaticallyImplyLeading: showLeading,
                  title: Text(title!),
                  actions: actions,
                )
              : null),
      body: child,
      //endDrawer: isTablet ? settingsHamburgerMenu : null,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
