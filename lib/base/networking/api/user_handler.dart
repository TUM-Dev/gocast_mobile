import 'package:gocast_mobile/models/user/user_model.dart';
import 'package:gocast_mobile/base/helpers/model_generator.dart';

/// Class responsible for fetching and posting user-related data (e.g., fetch user details, update usersettings, etc.)
class UserHandler {
  // Generate user mock for testing the views until API/v2 is implemented

  /// Performs SSO authentication.
  ///
  /// This method opens the SSO login page in a web view. After the user logs in,
  /// it saves the JWT token and redirects back to the app.
  ///
  /// Throws an [AppError] if a network error occurs or if no JWT-cookie is set.

  static Future<User> fetchUser() async {
    // TODO: Fetch user information from API (preferably over gRPC) - see issues
    return ModelGenerator.generateRandomUser();
  }
}
