import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/settings_view/authentication_error_card_view.dart';

class PreferredGreetingView extends ConsumerWidget {
  const PreferredGreetingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    final currentGreeting = userState.userSettings
            ?.firstWhere(
              (setting) => setting.type == UserSettingType.GREETING,
              orElse: () => UserSetting(value: 'Default Greeting'),
            )
            .value ??
        'Default Greeting';

    return ListTile(
      title: const Text('Preferred Greeting'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGreetingRadioOption(context, ref, 'Servus', currentGreeting),
          _buildGreetingRadioOption(context, ref, 'Moin', currentGreeting),
        ],
      ),
    );
  }

  Widget _buildGreetingRadioOption(
    BuildContext context,
    WidgetRef ref,
    String greeting,
    String currentGreeting,
  ) {
    return Row(
      children: [
        Radio<String>(
          value: greeting,
          groupValue: currentGreeting,
          onChanged: (String? newValue) async {
            if (newValue != null) {
              await _updatePreferredGreeting(context, ref, newValue);
            }
          },
        ),
        Text(greeting),
      ],
    );
  }

  Future<void> _updatePreferredGreeting(
    BuildContext context,
    WidgetRef ref,
    String newGreeting,
  ) async {
    if (await showAuthenticationErrorCard(context, ref)) {
      var userSettings = List<UserSetting>.from(
        ref.read(userViewModelProvider).userSettings ?? [],
      );
      var greetingSetting = userSettings.firstWhere(
        (setting) => setting.type == UserSettingType.GREETING,
        orElse: () =>
            UserSetting(type: UserSettingType.GREETING, value: newGreeting),
      );
      greetingSetting.value = newGreeting;
      if (!userSettings.contains(greetingSetting)) {
        userSettings.add(greetingSetting);
      }
      await ref
          .read(userViewModelProvider.notifier)
          .updateUserSettings(userSettings);
    }
  }
}
