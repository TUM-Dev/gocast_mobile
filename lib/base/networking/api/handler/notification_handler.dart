import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:logger/logger.dart';

class NotificationHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  NotificationHandler(this._grpcHandler);

  /// Registers a new device for push notificaitons.
  ///
  /// This method sends a `postDeviceToken` gRPC call to update the user's
  /// active device token list.
  Future<void> postDeviceToken(String deviceToken) async {
    _logger.i('Posting device token');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        await client
            .postDeviceToken(PostDeviceTokenRequest(deviceToken: deviceToken));
        _logger.i('Device token posted successfully');
      },
    );
  }

  /// Remove a device for push notificaitons.
  ///
  /// This method sends a `deleteDeviceToken` gRPC call to delete this device's
  /// the user's token from the user's active device token list.
  Future<void> deleteDeviceToken(String deviceToken) async {
    _logger.i('Deleting device token');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        await client.deleteDeviceToken(
          DeleteDeviceTokenRequest(deviceToken: deviceToken),
        );
        _logger.i('Device token deleted successfully');
      },
    );
  }

  /// Fetches featured notifications.
  ///
  /// This method sends a `getFeatureNotifications` gRPC call to fetch the featured notifications.
  ///
  /// returns a [List<Notification>] instance that represents the feature notifications.
  Future<List<FeatureNotification>> fetchFeatureNotifications() async {
    _logger.i('Fetching feature notifications');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client
            .getFeatureNotifications(GetFeatureNotificationsRequest());
        _logger.d('Feature notifications: ${response.featureNotifications}');
        return response.featureNotifications;
      },
    );
  }

  /// Fetches Banner Alerts.
  ///
  /// This method sends a `getBannerAlerts` gRPC call to fetch the banner alerts.
  ///
  /// returns a [List<BannerAlert>] instance that represents the banner alerts.
  Future<List<BannerAlert>> fetchBannerAlerts() async {
    _logger.i('Fetching banner alerts');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getBannerAlerts(GetBannerAlertsRequest());
        _logger.d('Banner alerts: ${response.bannerAlerts}');
        return response.bannerAlerts;
      },
    );
  }
}
