import 'package:flutter/material.dart';
import 'package:gocast_mobile/model/user_model.dart';
import 'package:gocast_mobile/viewModels/user_viewmodel.dart';
import 'package:gocast_mobile/views/home_view.dart';
import 'package:gocast_mobile/views/login_view.dart';
import 'package:gocast_mobile/views/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:gocast_mobile/bootstrap.dart';

void main() {
  bootstrap(() {
    return ChangeNotifierProvider(
      create: (context) =>
          UserState(isLoading: false, user: null, errorMessage: ''),
      child: const App(),
    );
  });

//  runApp(const MyApp());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final current = Provider.of<UserState>(context);
    final userViewModel = UserViewModel(current);

    return MaterialApp(
      title: 'gocast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0065bd)),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      home: current.user == null
          ? LoginView(
              key: const Key('loginView'),
              userViewModel: userViewModel,
            )
          : HomeView(
              key: const Key('homeView'),
              userViewModel: userViewModel,
            ),
      routes: {
        '/welcome': (context) => current.user == null
            ? LoginView(
                key: const Key('loginView'),
                userViewModel: UserViewModel(Provider.of<UserState>(context)),
              )
            : WelcomeView(
                key: const Key('welcomeView'),
                userViewModel: UserViewModel(Provider.of<UserState>(context)),
              ),
        '/home': (context) => current.user == null
            ? LoginView(
                key: const Key('loginView'),
                userViewModel: UserViewModel(Provider.of<UserState>(context)),
              )
            : HomeView(
                key: const Key('homeView'),
                userViewModel: UserViewModel(Provider.of<UserState>(context)),
              ),
      },
    );
  }
}
