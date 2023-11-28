import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/user/user_model.dart' as model;
import 'package:logger/logger.dart';

import 'grpc_handler.dart';

/// Handles user-related data operations.
///
/// This class is responsible for fetching and posting user-related data, such as fetching user details and updating user settings.
class UserHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  /// Creates a new instance of the `UserHandler` class.
  ///
  /// The [GrpcHandler] is required.
  UserHandler(this._grpcHandler);

  /// Fetches the current user and associated data.
  ///
  /// This method sends a `getUser` gRPC call to fetch the user details. It deserializes the gRPC response into a [model.User] instance.
  ///
  /// Returns a [model.User] instance that represents the user details.
  Future<model.User> fetchUser() async {
    _logger.i('Fetching user details');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        // Make the gRPC call
        final response = await client.getUser(GetUserRequest());
        _logger.i('User details fetched successfully');
        // Deserialize the gRPC response into a User instance
        _logger.d('User details: ${response.user}');
        return model.User.fromProto(response.user);
      },
    );
  }
}
