import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/notification_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/notifications/notification_state_model.dart';
import 'package:gocast_mobile/models/notifications/push_notification.dart';
import 'package:logger/logger.dart';

class NotificationViewModel extends StateNotifier<NotificationState> {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  NotificationViewModel(this._grpcHandler) : super(const NotificationState());

  addNotification(PushNotification notification) {
    _logger.i('Adding push notification');
    var pushNotifications = state.pushNotifications;

    pushNotifications ??= [];
    pushNotifications.add(notification);

    state = state.copyWith(pushNotifications: pushNotifications);
    _logger.w("PushNOtifications = ${pushNotifications.length}");
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
