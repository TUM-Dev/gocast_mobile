import 'package:gocast_mobile/base/networking/api/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/user/user_model.dart' as model;

/// Class responsible for fetching and posting user-related data (e.g., fetch user details, update usersettings, etc.)
class UserHandler {
  final GrpcHandler _grpcHandler;

  UserHandler(this._grpcHandler);

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
