import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:gocast_mobile/utils/theme.dart';
import 'package:gocast_mobile/navigation_tab.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/public_courses_view.dart';
import 'package:gocast_mobile/views/login_view/internal_login_view.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gocast_mobile/l10n/l10n.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  Logger.level = Level.info;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
     const ProviderScope(
      child: App(),
    ),
  );
}

bool isPushNotificationListenerSet = false;

class App extends ConsumerWidget {

   const App({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);

    bool isLoggedIn = ref.watch(userViewModelProvider).user != null;


    _handleErrors(ref, userState);
    _setupNotifications(ref, userState);

    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: const Locale('de'),
      theme: appTheme, // Your light theme
      darkTheme: darkAppTheme, // Define your dark theme
      themeMode:
          ref.watch(themeModeProvider), // Use the theme mode from the provider
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: !isLoggedIn
          ? const WelcomeScreen()
          : const NavigationTab(),
      routes: _buildRoutes(),
    );
  }

  void _handleErrors(WidgetRef ref, UserState userState) {
    // Check for errors in userState and show a SnackBar if there are any
    if (userState.error != null) {
      Future.microtask(() {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Error: ${userState.error!.message}')),
        );
        // Clear the error
        ref.read(userViewModelProvider).clearError();
      });
    }
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/welcome': (context) => const WelcomeScreen(),
      '/login': (context) => const InternalLoginScreen(),
      '/navigationTab': (context) => const NavigationTab(),
      '/publiccourses': (context) => const PublicCourses(),
    };
  }

  _setupNotifications(WidgetRef ref, UserState userState) {
    final nvmn = ref.read(notificationViewModelProvider.notifier);

    // Push notifications (e.g. "stream xyz just started") are shown only once
    nvmn.initPushNotifications();

    if (userState.user != null) {
      // Upload notifications (e.g., "New VoD for course xyz" are available for
      // logged in users only and can be also seen in the "notificaions" tab
      nvmn.handleUploadNotifications(ref);
    }
  }
}
