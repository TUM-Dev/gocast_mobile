import 'package:gocast_mobile/base/networking/api/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/user/user_model.dart' as model;

/// Handles user-related data operations.
///
/// This class is responsible for fetching and posting user-related data, such as fetching user details and updating user settings.
class UserHandler {
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
    return await _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getUser(GetUserRequest());
        // Deserialize the gRPC response into a User instance
        return model.User.fromProto(response.user);
      },
    );
  }
}
