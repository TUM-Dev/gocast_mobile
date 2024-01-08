import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/settings_view/playback_speed_picker_view.dart';
import 'package:gocast_mobile/views/settings_view/custom_playback_speed_view.dart';
import 'package:gocast_mobile/views/settings_view/authentication_error_card_view.dart';

class PlaybackSpeedSettings extends ConsumerWidget {
  const PlaybackSpeedSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    final selectedPlaybackSpeeds = _parsePlaybackSpeeds(userState.userSettings);

    return Column(
      children: [
        _buildPlaybackSpeedsTile(context, ref, selectedPlaybackSpeeds),
        _buildCustomPlaybackSpeedsTile(context, ref),
      ],
    );
  }

  ListTile _buildPlaybackSpeedsTile(
    BuildContext context,
    WidgetRef ref,
    List<double> playbackSpeeds,
  ) {
    return ListTile(
      title: const Text('Playback Speeds'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => showPlaybackSpeedsPicker(
        context,
        ref,
        playbackSpeeds,
        (double speed, bool isSelected) {
          _updateSelectedSpeeds(context, ref, speed, isSelected);
        },
      ),
    );
  }

  ListTile _buildCustomPlaybackSpeedsTile(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Add Custom Playback Speed'),
      onTap: () {
        showAddCustomSpeedDialog(context, (double customSpeed) {
          _updateSelectedSpeeds(context, ref, customSpeed, true);
        });
      },
    );
  }

  List<double> _parsePlaybackSpeeds(List<UserSetting>? userSettings) {
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
        // Handle parsing error
        return [];
      }
    }
    return [];
  }

  void _updateSelectedSpeeds(
    BuildContext context,
    WidgetRef ref,
    double speed,
    bool isSelected,
  ) {
    final currentUserSettings =
        ref.read(userViewModelProvider).userSettings ?? [];
    List<double> updatedSpeeds = _parsePlaybackSpeeds(currentUserSettings);

    if (isSelected) {
      updatedSpeeds.add(speed);
    } else {
      updatedSpeeds.remove(speed);
    }
    _updatePlaybackSpeeds(context, ref, updatedSpeeds);
  }

  Future<void> _updatePlaybackSpeeds(
    BuildContext context,
    WidgetRef ref,
    List<double> speeds,
  ) async {
    bool isAuthenticated = await showAuthenticationErrorCard(context, ref);
    if (isAuthenticated) {
      // Fetch current user settings
      final currentUserSettings =
          ref.read(userViewModelProvider).userSettings ?? [];

      // Prepare the updated playback speeds setting
      List<Map<String, dynamic>> speedsList =
          speeds.map((speed) => {"speed": speed, "enabled": true}).toList();
      final String speedsJson = jsonEncode(speedsList);
      final UserSetting updatedPlaybackSpeedSetting = UserSetting(
        type: UserSettingType.CUSTOM_PLAYBACK_SPEEDS,
        value: speedsJson,
      );

      // Replace the existing playback speeds setting with the updated one
      final updatedUserSettings = [
        for (var setting in currentUserSettings)
          if (setting.type != UserSettingType.CUSTOM_PLAYBACK_SPEEDS) setting,
        updatedPlaybackSpeedSetting,
      ];

      // Update user settings with the modified list
      await ref
          .read(userViewModelProvider.notifier)
          .updateUserSettings(updatedUserSettings);

      // Fetch updated settings
      ref.read(userViewModelProvider.notifier).fetchUserSettings();
    }
  }
}
