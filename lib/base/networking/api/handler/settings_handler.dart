import 'dart:convert';

import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:logger/logger.dart';

import 'grpc_handler.dart';

/// Handles user settings-related data operations.
///
/// This class is responsible for fetching and updating user settings.
class SettingsHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  /// Creates a new instance of the `SettingsHandler` class.
  ///
  /// The [GrpcHandler] is required.
  SettingsHandler(this._grpcHandler);

  /// Fetches the current user's settings.
  ///
  /// This method sends a `getUserSettings` gRPC call to fetch the user's settings.
  ///
  /// Returns a [List<UserSetting>] instance that represents the user's settings.
  Future<List<UserSetting>> fetchUserSettings() async {
    try {
      _logger.i('Fetching user settings');
      final response = await _grpcHandler.callGrpcMethod(
        (client) async {
          final response =
              await client.getUserSettings(GetUserSettingsRequest());
          _logger.i('User settings fetched successfully');
          _logger.d('User settings: ${response.userSettings}');
          return response.userSettings;
        },
      );
      return response;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  /// Updates the user settings.
  ///
  /// This method sends an `updateUserSettings` gRPC call to update the user's settings on the server.
  ///
  /// [updatedSettings] - The updated user settings to be saved.
  ///
  /// Returns a [bool] indicating whether the update was successful or not.
  Future<bool> updateUserSettings(List<UserSetting> updatedSettings) async {
    try {
      _logger.i('Updating user settings...');
      final request = PatchUserSettingsRequest()
        ..userSettings.addAll(updatedSettings);

      await _grpcHandler.callGrpcMethod(
        (client) async {
          await client.patchUserSettings(request);
          _logger.i('User settings updated successfully');
        },
      );

      return true;
    } catch (e) {
      _logger.e('Error updating user settings: $e');
      rethrow;
    }
  }

  Future<void> updatePreferredName(String name) async {
    UserSetting nameSetting =
        UserSetting(type: UserSettingType.PREFERRED_NAME, value: name);
    await updateUserSettings([nameSetting]);
  }

  Future<void> updatePreferredGreeting(String greeting) async {
    UserSetting greetingSetting =
        UserSetting(type: UserSettingType.GREETING, value: greeting);
    await updateUserSettings([greetingSetting]);
  }

  Future<void> updatePlaybackSpeeds(List<double> speeds) async {
    List<Map<String, dynamic>> speedsList =
        speeds.map((speed) => {"speed": speed, "enabled": true}).toList();
    String speedsJson = jsonEncode(speedsList);
    UserSetting playbackSpeedSetting = UserSetting(
        type: UserSettingType.CUSTOM_PLAYBACK_SPEEDS, value: speedsJson);
    await updateUserSettings([playbackSpeedSetting]);
  }
}
