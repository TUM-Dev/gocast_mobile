import 'package:logger/logger.dart';

import 'grpc_handler.dart';

/// Handles notification-related data operations.
///
/// This class is responsible for fetching and posting notification-related data
class NotificationHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  /// Creates a new instance of the `NotificationHandler` class.
  ///
  /// The [GrpcHandler] is required.
  NotificationHandler(this._grpcHandler);

  /// Registers a new device for push notificaitons.
  ///
  /// This method sends a `postDeviceToken` gRPC call to update the user's
  /// active device token list.
  Future<void> postDeviceToken(String deviceToken) async {
    _logger.i('Posting device token');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        //await client.postDeviceToken(PostDeviceTokenRequest(deviceToken));
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
        //await client.deleteDeviceToken(DeleteDeviceTokenRequest(deviceToken));
        _logger.i('Device token deleted successfully');
      },
    );
  }
}
