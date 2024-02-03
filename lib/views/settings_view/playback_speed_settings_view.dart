import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/settings_view/playback_speed_picker_view.dart';
import 'package:gocast_mobile/views/settings_view/custom_playback_speed_view.dart';
import 'package:gocast_mobile/views/settings_view/authentication_error_card_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaybackSpeedSettings extends ConsumerWidget {
  const PlaybackSpeedSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingState = ref.watch(settingViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final speeds = _initPlaybackSpeeds(settingState.userSettings, ref);
      // Only update if necessary to avoid infinite loops
      if (ref.read(playbackSpeedsProvider.notifier).state != speeds) {
        ref.read(playbackSpeedsProvider.notifier).state = speeds;
      }
    });
    final selectedPlaybackSpeeds = ref.watch(playbackSpeedsProvider);

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
      title:  Text(AppLocalizations.of(context)!.playback_speed),
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
      title: Text(AppLocalizations.of(context)!.add_custom_playback_speed),
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

  List<double> _initPlaybackSpeeds(
    List<UserSetting>? userSettings,
    WidgetRef ref,
  ) {
    final settingViewModel = ref.read(settingViewModelProvider.notifier);
    final speeds = settingViewModel.parsePlaybackSpeeds();
    ref.read(playbackSpeedsProvider.notifier).state = speeds;
    return ref.read(playbackSpeedsProvider);
  }
}
