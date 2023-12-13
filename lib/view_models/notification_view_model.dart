import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/notification_handler.dart';
import 'package:logger/logger.dart';

class NotificationViewModel {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;
  String deviceToken;

  NotificationViewModel(this._grpcHandler, this.deviceToken);

  Future<void> postDeviceToken(String deviceToken) async {
    try {
      this.deviceToken = deviceToken;
      _logger.i('Posting device token');
      await NotificationHandler(_grpcHandler).postDeviceToken(deviceToken);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> deleteDeviceToken(String deviceToken) async {
    try {
      this.deviceToken = "";
      _logger.i('Deleting device token');
      await NotificationHandler(_grpcHandler).deleteDeviceToken(deviceToken);
    } catch (e) {
      _logger.e(e);
    }
  }
}
