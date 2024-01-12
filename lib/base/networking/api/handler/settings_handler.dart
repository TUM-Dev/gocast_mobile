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

  /// Parses playback speeds from the user settings.
  List<double> parsePlaybackSpeeds(List<UserSetting>? userSettings) {
    final playbackSpeedSetting = userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
      orElse: () => UserSetting(value: jsonEncode([])),
    );

    if (playbackSpeedSetting != null && playbackSpeedSetting.value.isNotEmpty) {
      try {
        final List<dynamic> speedsJson = jsonDecode(playbackSpeedSetting.value);
        return speedsJson
            .where((item) => item['enabled'] == true)
            .map((item) => double.parse(item['speed'].toString()))
            .toList();
      } catch (e) {
        _logger.e('Error parsing playback speeds: $e');
        return [];
      }
    }
    return [];
  }

  /// Updates the preferred greeting in user settings.
  Future<bool> updatePreferredGreeting(
      String newGreeting, List<UserSetting> currentSettings,) async {
    try {
      var greetingSetting = currentSettings.firstWhere(
        (setting) => setting.type == UserSettingType.GREETING,
        orElse: () =>
            UserSetting(type: UserSettingType.GREETING, value: newGreeting),
      );
      greetingSetting.value = newGreeting;

      if (!currentSettings.contains(greetingSetting)) {
        currentSettings.add(greetingSetting);
      }
      await updateUserSettings(currentSettings);
      return true;
    } catch (e) {
      _logger.e('Error updating greeting: $e');
      return false;
    }
  }

  /// Updates the preferred name in user settings.
  Future<bool> updatePreferredName(
      String newName, List<UserSetting> currentSettings,) async {
    try {
      var newSetting =
          UserSetting(type: UserSettingType.PREFERRED_NAME, value: newName);
      await updateUserSettings([newSetting]);
      return true;
    } catch (e) {
      _logger.e('Error updating preferred name: $e');
      return false;
    }
  }

  /// Updates the selected speeds in user settings.
  Future<void> updateSelectedSpeeds(
      double speed, bool isSelected, List<UserSetting> currentSettings) async {
    var playbackSpeedSetting = currentSettings.firstWhere(
          (setting) => setting.type == UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
      orElse: () => UserSetting(
        type: UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
        value: jsonEncode([{"speed": 1.0, "enabled": true}]),
      ),
    );
    var speeds = (jsonDecode(playbackSpeedSetting.value) as List)
        .map((e) => e["speed"])
        .toSet();
    isSelected ? speeds.add(speed) : speeds.remove(speed);
    speeds.add(1.0); // Ensure default speed is always included
    playbackSpeedSetting.value = jsonEncode(
      speeds.map((s) => {"speed": s, "enabled": true}).toList(),
    );
    if (!currentSettings.contains(playbackSpeedSetting)) {
      currentSettings.add(playbackSpeedSetting);
    }
    await updateUserSettings(currentSettings);
  }

}
