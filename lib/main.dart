import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:gocast_mobile/utils/theme.dart';
import 'package:gocast_mobile/view_models/notification_view_model.dart';
import 'package:gocast_mobile/views/course_view/courses_overview.dart';
import 'package:gocast_mobile/views/course_view/list_courses_view/public_courses_view.dart';
import 'package:gocast_mobile/views/login_view/internal_login_view.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:logger/logger.dart';
import 'package:touch_indicator/touch_indicator.dart';

import 'base/networking/api/gocast/api_v2.pb.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

const InitializationSettings initializationSettings = InitializationSettings(
  android: androidInitializationSettings,
);

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await initializeLocalNotifications();

  Logger.level = Level.debug;
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> initializeLocalNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    final notificationViewModel = ref.watch(notificationViewModelProvider);

    _handleErrors(ref, userState);
    // Push notifications available for logged in users only
    if (userState.user != null) {
      _handlePushNotifications(notificationViewModel);
    }
    // Set the home screen based on the user's state
    final Widget homeScreen = _getHomeScreen(userState.user);

    return MaterialApp(
      theme: appTheme,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      builder: (context, child) {
        _setPreferredOrientations(context);
        return TouchIndicator(child: child!);
      },
      home: homeScreen,
      routes: _buildRoutes(),
    );
  }

  void _handlePushNotifications(NotificationViewModel notificationViewModel) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    messaging.getToken().then((token) {
      debugPrint('Device Token: $token');
      if (token != null && token != notificationViewModel.deviceToken) {
        notificationViewModel.postDeviceToken(token);
      }
    });

    messaging.onTokenRefresh.listen((token) {
      if (token != notificationViewModel.deviceToken) {
        notificationViewModel.postDeviceToken(token);
      }
      debugPrint('Token refreshed: $token');
    });
    // TODO: REMOVE TOKEN WHEN LOGGING OUT

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("New message arrived: ${message.data.entries.first}");
      String? msg = message.data['msg'];
      String? sum = message.data['sum'];

      if (msg != null && sum != null) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(sum),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(msg),
                  ],
                ),
              ),
            );
          },
        );
      }
    });

    // Handle incoming messages when the app is in the background but visible
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('TODO: A new onMessageOpenedApp event was published!');
    });
  }

  void _handleErrors(WidgetRef ref, UserState userState) {
    // Check for errors in userState and show a SnackBar if there are any
    if (userState.error != null) {
      Future.microtask(
        () {
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text('Error: ${userState.error!.message}')),
          );

          // Clear the error
          ref.read(userViewModelProvider.notifier).clearError();
        },
      );
    }
  }

  void _setPreferredOrientations(BuildContext context) {
    if (MediaQuery.of(context).size.shortestSide < 600) {
      // This is likely a phone
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      // This is likely a tablet
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Widget _getHomeScreen(User? user) {
    return user == null ? const WelcomeScreen() : const CourseOverview();
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/welcome': (context) => const WelcomeScreen(),
      '/login': (context) => const InternalLoginScreen(),
      '/courses': (context) => const CourseOverview(),
      '/publiccourses': (context) => const PublicCourses(),
    };
  }
}
