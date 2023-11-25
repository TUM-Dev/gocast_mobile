import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/model/error_model.dart';
import 'package:gocast_mobile/views/courseoverview_screen.dart';
import 'package:gocast_mobile/model/user/user_state_model.dart';
import 'package:gocast_mobile/view_models/user_viewmodel.dart';
import 'package:gocast_mobile/views/welcome_screen.dart';

final userViewModel = Provider((ref) => UserViewModel());

final userStateProvider = StreamProvider<UserState>((ref) {
  return ref.watch(userViewModel).current.stream;
});

void main() {
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
    final userState = ref.watch(userStateProvider);

    if (userState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppError error = userState.error as AppError;
        scaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(content: Text('Error: ${error.message}')),
        );
      });
    }

    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (context) => userState.value?.user == null
            ? const WelcomeScreen(key: Key('welcomeView'))
            : const CourseOverview(key: Key('courseView')),
        '/home': (context) => userState.value?.user == null
            ? const WelcomeScreen(key: Key('welcomeView'))
            : const CourseOverview(key: Key('courseView')),
      },
    );
  }
}
