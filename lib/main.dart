import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/View/login_screen.dart';
import 'package:gocast_mobile/model/user/user_state_model.dart';
import 'package:gocast_mobile/viewModels/user_viewmodel.dart';
import 'package:gocast_mobile/views/home_view.dart';
import 'package:gocast_mobile/views/welcome_view.dart';
import 'package:gocast_mobile/View/welcome_screen.dart';
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
        scaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(content: Text('Error: ${userState.error}')),
        );
      });
    }

    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,

      home: const WelcomeScreen(),
      routes: {
        '/welcome': (context) => userState.value?.user == null
            ? const Loginscreen(key: Key('loginView'))
            : const WelcomeView(key: Key('welcomeView')),
        '/home': (context) => userState.value?.user == null
            ? const Loginscreen(key: Key('loginView'))
            : const HomeView(key: Key('homeView')),
      },
    );
  }
}
