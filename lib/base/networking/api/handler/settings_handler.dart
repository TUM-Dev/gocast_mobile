import 'dart:convert';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:logger/logger.dart';

import 'grpc_handler.dart';

/// Handles user settings related data operations.
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
  /// This method sends a `getUserSettings` gRPC call to fetch the user's
  /// settings.
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
  /// This method sends an `updateUserSettings` gRPC call to update the user's
  /// settings on the server.
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
}

class UserSettings {
  final int id;
  final int userID;
  final String type;
  final String? value;
  final List<PlaybackSpeed>? playbackSpeeds;
  final String? greeting;

  UserSettings({
    required this.id,
    required this.userID,
    required this.type,
    this.value,
    this.playbackSpeeds,
    this.greeting,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    final String type = json['type'] as String;
    switch (type) {
      case "CUSTOM_PLAYBACK_SPEEDS":
        final List<dynamic> speedList = jsonDecode(json['value'] ?? '[]');
        final List<PlaybackSpeed> playbackSpeeds = speedList
            .map(
              (speedData) =>
                  PlaybackSpeed.fromJson(speedData as Map<String, dynamic>),
            )
            .toList();
        return UserSettings(
          id: json['id'] as int,
          userID: json['userID'] as int,
          type: type,
          value: json['value'] as String?,
          playbackSpeeds: playbackSpeeds,
        );
      case "GREETING":
        return UserSettings(
          id: json['id'] as int,
          userID: json['userID'] as int,
          type: type,
          value: json['value'] as String?,
          greeting: json['value'] as String?,
        );
      default:
        return UserSettings(
          id: json['id'] as int,
          userID: json['userID'] as int,
          type: type,
          value: json['value'] as String?,
        );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'userID': userID,
      'type': type,
      'value': value,
    };

    if (playbackSpeeds != null) {
      data['playbackSpeeds'] =
          playbackSpeeds!.map((speed) => speed.toJson()).toList();
    }
    if (greeting != null) {
      data['greeting'] = greeting;
    }
    return data;
  }
}

class PlaybackSpeed {
  final double speed;
  final bool enabled;

  PlaybackSpeed({
    required this.speed,
    required this.enabled,
  });

  factory PlaybackSpeed.fromJson(Map<String, dynamic> json) {
    return PlaybackSpeed(
      speed: json['speed'] as double,
      enabled: json['enabled'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'enabled': enabled,
    };
  }
}
