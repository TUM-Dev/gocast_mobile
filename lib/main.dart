import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/view_models/UserViewModel.dart';
import 'package:gocast_mobile/views/course_view/courses_overview_view.dart';
import 'package:gocast_mobile/views/login_view/internal_login_view.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:gocast_mobile/views/utils/globals.dart';
import 'package:gocast_mobile/views/utils/routes.dart';
import 'package:gocast_mobile/views/utils/theme.dart';
import 'package:logger/logger.dart';

import 'base/networking/api/gocast/api_v2.pb.dart';

final grpcHandlerProvider =
    Provider((ref) => GrpcHandler(Routes.grpcHost, Routes.grpcPort));
final userViewModel =
    Provider((ref) => UserViewModel(ref.watch(grpcHandlerProvider)));

void main() {
  Logger.level = Level.debug;
  runApp(const ProviderScope(child: App()));
}

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<UserState>(
      stream: ref.watch(userViewModel).current.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final error = snapshot.error as AppError;
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => scaffoldMessengerKey.currentState!.showSnackBar(
              SnackBar(content: Text('Error: ${error.message}')),
            ),
          );
        }

        final Widget homeScreen = _getHomeScreen(snapshot.data?.user);

        return MaterialApp(
          theme: appTheme,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          home: homeScreen,
          routes: _buildRoutes(homeScreen),
        );
      },
    );
  }

  Widget _getHomeScreen(User? user) {
    return user == null ? const WelcomeScreen() : const CourseOverview();
  }

  Map<String, WidgetBuilder> _buildRoutes(Widget homeScreen) {
    return {
      '/welcome': (context) => homeScreen,
      '/home': (context) => homeScreen,
      '/login': (context) => const InternalLoginScreen(),
      '/courses': (context) => const CourseOverview(),
    };
  }
}
