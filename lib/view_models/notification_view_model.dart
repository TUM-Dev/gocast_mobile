import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/notification_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:logger/logger.dart';

class NotificationViewModel {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  NotificationViewModel(this._grpcHandler);

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
}
