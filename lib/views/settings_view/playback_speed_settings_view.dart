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
    final settingState = ref.watch(settingViewModelProvider);
    final selectedPlaybackSpeeds =
        _parsePlaybackSpeeds(settingState.userSettings, ref);

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

  void _updateSelectedSpeeds(
    BuildContext context,
    WidgetRef ref,
    double speed,
    bool isSelected,
  ) async {
    bool isAuthenticated = await showAuthenticationErrorCard(context, ref);
    if (!isAuthenticated) return;

    await ref
        .read(settingViewModelProvider.notifier)
        .updateSelectedSpeeds(speed, isSelected);
  }

  List<double> _parsePlaybackSpeeds(
    List<UserSetting>? userSettings,
    WidgetRef ref,
  ) {
    return ref.read(settingViewModelProvider.notifier).parsePlaybackSpeeds();
  }
}
