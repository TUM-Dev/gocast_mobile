import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/notification_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:gocast_mobile/main.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/notifications/notification_state_model.dart';
import 'package:gocast_mobile/models/notifications/push_notification.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/globals.dart';
import 'package:logger/logger.dart';

class NotificationViewModel extends StateNotifier<NotificationState> {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  NotificationViewModel(this._grpcHandler) : super(const NotificationState());

  /// Create instance of FCM
  final _firebaseMessaging = FirebaseMessaging.instance;

  /// Function to initialize notifications
  Future<void> initPushNotifications() async {
    // Request permission from user
    await _firebaseMessaging.requestPermission();

    String? deviceToken;
    try {
      deviceToken = await _firebaseMessaging.getToken();
    }catch(e){
      throw AppError.notificationNotAvailableYet();
    }
    // Send device_token to API
    if (deviceToken != null) await postDeviceToken(deviceToken);

    // App was terminated and now openen
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Attach event listener for notification opening the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  /// Function to handle received messages
  handleMessage(RemoteMessage? message) {
    _logger.e("HandleMessage: $message");
    if (message == null) return;

    final msg = message.data['msg'];
    final sum = message.data['sum'];

    if (msg != null && sum != null) {
      PushNotification notification = PushNotification(
        body: msg,
        title: sum,
        receivedAt: DateTime.now(),
        data: message.data,
      );
      addNotification(notification);
    }
  }

  addNotification(PushNotification notification) {
    _logger.i('Adding push notification');
    var pushNotifications = state.pushNotifications;

    pushNotifications ??= [];
    pushNotifications.add(notification);

    state = state.copyWith(pushNotifications: pushNotifications);
    _logger.w("PushNotifications = ${pushNotifications.length}");
  }

  void handleUploadNotifications(ref) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.requestPermission();

    final nvmn = ref.read(notificationViewModelProvider.notifier);

    if (!isPushNotificationListenerSet) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final msg = message.data['msg'];
        final sum = message.data['sum'];

        if (msg != null && sum != null) {
          PushNotification notification = PushNotification(
            body: msg,
            title: sum,
            receivedAt: DateTime.now(),
            data: message.data,
          );
          nvmn.addNotification(notification);
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(notification.body),
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
      isPushNotificationListenerSet = true;
    }
  }

  Future<void> postDeviceToken(String deviceToken) async {
    try {
      TokenHandler.saveToken("device_token", deviceToken);
      _logger.i('Posting device token');
      await NotificationHandler(_grpcHandler).postDeviceToken(deviceToken);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> deleteDeviceToken() async {
    try {
      var deviceToken = await TokenHandler.loadTokenNoException("device_token");
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'device_token');
      _logger.i('Deleting device token');
      await NotificationHandler(_grpcHandler).deleteDeviceToken(deviceToken);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> fetchFeatureNotifications() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching feature notifications');
      var featureNotifications =
          await NotificationHandler(_grpcHandler).fetchFeatureNotifications();
      state = state.copyWith(
        featureNotifications: featureNotifications,
        isLoading: false,
      );
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchBannerAlerts() async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('Fetching banner alerts');
      var bannerAlerts =
          await NotificationHandler(_grpcHandler).fetchBannerAlerts();
      state = state.copyWith(bannerAlerts: bannerAlerts, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }
}
