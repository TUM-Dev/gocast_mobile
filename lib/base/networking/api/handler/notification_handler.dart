import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:logger/logger.dart';

/// Handles Notification-related data operations.
///
/// This class is responsible for fetching and posting notification-related data, such as fetching feature Notification and banner Alerts.
class NotificationHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  NotificationHandler(this._grpcHandler);

  Future<List<FeatureNotification>> fetchFeatureNotifications() async {
    _logger.i('Fetching public courses');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client
            .getFeatureNotifications(GetFeatureNotificationsRequest());
        _logger.d('Public courses: ${response.featureNotifications}');
        return response.featureNotifications;
      },
    );
  }

  Future<List<BannerAlert>> fetchBannerAlerts() async {
    _logger.i('Fetching public courses');
    return _grpcHandler.callGrpcMethod(
          (client) async {
        final response = await client
            .getBannerAlerts(GetBannerAlertsRequest());
        _logger.d('Public courses: ${response.bannerAlerts}');
        return response.bannerAlerts;
      },
    );
  }

  //TODO push notifications
}
