import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:gocast_mobile/utils/theme.dart';
import 'package:gocast_mobile/navigation_tab.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/public_courses_view.dart';
import 'package:gocast_mobile/views/login_view/internal_login_view.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:logger/logger.dart';

import 'base/networking/api/gocast/api_v2.pb.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.debug;
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    final themeMode = ref.watch(themeModeProvider);
    // Check for errors in userState and show a SnackBar if any
    if (userState.error != null) {
      Future.microtask(() {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Error: ${userState.error!.message}')),
        );
        // Clear the error
        ref.read(userViewModelProvider).clearError();
      });
    }

    // Decide the home screen based on the user's state
    final Widget homeScreen = _getHomeScreen(userState.user);

    return MaterialApp(
      theme: appTheme, // Your light theme
      darkTheme: darkAppTheme, // Define your dark theme
      themeMode: themeMode, // Use the theme mode from the provider
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: homeScreen,
      routes: _buildRoutes(),
    );
  }

  Widget _getHomeScreen(User? user) {
    return user == null ? const WelcomeScreen() : const NavigationTab();
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/welcome': (context) => const WelcomeScreen(),
      '/login': (context) => const InternalLoginScreen(),
      '/navigationTab': (context) => const NavigationTab(),
      '/publiccourses': (context) => const PublicCourses(),
    };
  }
}
