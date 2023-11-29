import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/view_models/user_viewmodel.dart';
import 'package:gocast_mobile/views/course_view/courses_overview_view.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:gocast_mobile/views/utils/globals.dart';
import 'package:gocast_mobile/views/utils/routes.dart';
import 'package:gocast_mobile/views/utils/theme.dart';

import 'package:logger/logger.dart';


final grpcHandlerProvider = Provider((ref) {
  final grpcHandler = GrpcHandler(Routes.grpcHost, Routes.grpcPort);
  return grpcHandler;
});

final userViewModel = Provider((ref) {
  final grpcHandler = ref.watch(grpcHandlerProvider);
  return UserViewModel(grpcHandler);
});

void main() {
  Logger.level = Level.debug;
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
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
          AppError error = snapshot.error as AppError;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scaffoldMessengerKey.currentState!.showSnackBar(
              SnackBar(content: Text('Error: ${error.message}')),
            );
          });
        }

        return MaterialApp(
          theme: appTheme,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          home: snapshot.data?.user == null
              ? const WelcomeScreen(key: Key('welcomeView'))
              : const CourseOverview(key: Key('courseView')),
          routes: {
            '/welcome': (context) => snapshot.data?.user == null
                ? const WelcomeScreen(key: Key('welcomeView'))
                : const CourseOverview(key: Key('courseView')),
            '/home': (context) => snapshot.data?.user == null
                ? const WelcomeScreen(key: Key('welcomeView'))
                : const CourseOverview(key: Key('courseView')),
          },
        );
      },
    );
  }
}
