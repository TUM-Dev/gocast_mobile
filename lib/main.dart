import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:gocast_mobile/utils/theme.dart';
import 'package:gocast_mobile/views/course_view/courses_overview_view.dart';
import 'package:gocast_mobile/views/login_view/internal_login_view.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:logger/logger.dart';

import 'base/networking/api/gocast/api_v2.pb.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  Logger.level = Level.debug;
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);

    // Check for errors in userState and show a SnackBar if any
    if (userState.error != null) {
      Future.microtask(
        () => scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Error: ${userState.error!.message}')),
        ),
      );
    }

    // Decide the home screen based on the user's state
    final Widget homeScreen = _getHomeScreen(userState.user);

    return MaterialApp(
      theme: appTheme,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: homeScreen,
      routes: _buildRoutes(),
    );
  }

  Widget _getHomeScreen(User? user) {
    return user == null ? const WelcomeScreen() : const CourseOverview();
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/welcome': (context) => const WelcomeScreen(),
      '/login': (context) => const InternalLoginScreen(),
      '/courses': (context) => const CourseOverview(),
    };
  }
}
