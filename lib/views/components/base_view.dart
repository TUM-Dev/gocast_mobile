import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/custom_bottom_nav_bar.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';

class BaseView extends ConsumerStatefulWidget {
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
    this.showLeading = false,
    this.customAppBar,
    this.bottomNavigationBar = const CustomBottomNavBar(),
    this.settingsHamburgerMenu = const SettingsScreen(),
  });

  @override
  BaseViewState createState() => BaseViewState();
}

class BaseViewState extends ConsumerState<BaseView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  Widget _buildHamburgerMenu(BuildContext context) {
    final double drawerWidth = MediaQuery.of(context).size.width * 0.5;
    return Drawer(
      width: drawerWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
        child: widget.settingsHamburgerMenu,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: widget.customAppBar ??
          AppBar(
            automaticallyImplyLeading: widget.showLeading,
            title: widget.title != null ? Text(widget.title!) : null,
            actions: _isTablet(context)
                ? [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                    ),
                  ]
                : widget.actions,
            surfaceTintColor: Colors.transparent,
          ),
      body: widget.child,
      endDrawer: _isTablet(context) && widget.customAppBar == null
          ? _buildHamburgerMenu(context)
          : null,
      bottomNavigationBar: widget.bottomNavigationBar,
      onEndDrawerChanged: (isOpen) {
        if (isOpen) {
          ref.read(settingViewModelProvider.notifier).loadPreferences();
        }
      },
    );
  }
}
