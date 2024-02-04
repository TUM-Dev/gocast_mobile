import 'dart:convert';

import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:logger/logger.dart';

import 'grpc_handler.dart';

class SettingsHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  SettingsHandler(this._grpcHandler);

  /// Fetches the user settings.
  ///
  /// This method sends a `getUserSettings` gRPC call to fetch the user's settings from the server.
  ///
  /// Returns a [List] of [UserSetting]s.
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
  /// This method sends a `patchUserSettings` gRPC call to update the user's settings on the server.
  ///   * [updatedSettings] - The updated settings.
  /// Returns `true` if the update was successful.
  Future<bool> updateUserSettings(List<UserSetting> updatedSettings) async {
    try {
      _logger.i('Updating user settings');
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
      return false;
    }
  }

  /// Updates the user's preferred name.
  ///
  /// This method sends a `patchUserSettings` gRPC call to update the user's preferred name on the server.
  ///   * [newName] - The new preferred name.
  /// Returns `true` if the update was successful.
  Future<void> updatePreferredName(String newName) async {
    try {
      _logger.i('Updating user settings...');
      final request = PatchUserSettingsRequest()
        ..userSettings.add(
          UserSetting(type: UserSettingType.PREFERRED_NAME, value: newName),
        );
      await _grpcHandler.callGrpcMethod(
        (client) async {
          await client.patchUserSettings(request);
          _logger.i('User settings updated successfully');
        },
      );
    } catch (e) {
      _logger.e('Error updating user settings: $e');
      rethrow;
    }
  }

  /// Updates the user's preferred greeting.
  ///
  /// This method sends a `patchUserSettings` gRPC call to update the user's preferred greeting on the server.
  ///  * [newGreeting] - The new preferred greeting.
  ///  Returns `true` if the update was successful.
  Future<bool> updateGreeting(String newGreeting) async {
    try {
      _logger.i('Updating user settings...');
      final request = PatchUserSettingsRequest()
        ..userSettings.add(
          UserSetting(type: UserSettingType.GREETING, value: newGreeting),
        );

      await _grpcHandler.callGrpcMethod(
        (client) async {
          await client.patchUserSettings(request);
          _logger.i('User settings updated successfully');
        },
      );
      return true;
    } catch (e) {
      _logger.e('Error updating user settings: $e');
      return false;
    }
  }

  /// Parses playback speeds from the user settings.
  ///
  /// This method parses the playback speeds from the user settings and returns them as a [List] of [double]s.
  ///  * [userSettings] - The user settings.
  ///  Returns a [List] of [double]s.
  List<double> parsePlaybackSpeeds(List<UserSetting>? userSettings) {
    final playbackSpeedSetting = userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
      orElse: () => UserSetting(value: jsonEncode([])),
    );

    if (playbackSpeedSetting != null && playbackSpeedSetting.value.isNotEmpty) {
      try {
        final List<dynamic> speedsJson = jsonDecode(playbackSpeedSetting.value);
        var sortedSpeeds = speedsJson
            .where((item) => item['enabled'] == true)
            .map((item) => double.parse(item['speed'].toString()))
            .toList();
        sortedSpeeds.sort();
        return sortedSpeeds;
      } catch (e) {
        _logger.e('Error parsing playback speeds: $e');
        return [];
      }
    }
    return [];
  }

  /// Updates the selected speeds in user settings.
  ///
  /// This method updates the selected speeds in user settings and sends a `patchUserSettings` gRPC call to update the user's settings on the server.
  /// * [speed] - The speed to update.
  /// * [isSelected] - Whether the speed is selected or not.
  /// * [currentSettings] - The current user settings.
  /// Returns `true` if the update was successful.
  Future<void> updateSelectedSpeeds(
    double speed,
    bool isSelected,
    List<UserSetting> currentSettings,
  ) async {
    var playbackSpeedSetting = currentSettings.firstWhere(
      (setting) => setting.type == UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
      orElse: () => UserSetting(
        type: UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
        value: jsonEncode([
          {"speed": 1.0, "enabled": true},
        ]),
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
    await updateUserSettings([playbackSpeedSetting]);
  }
}
