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
    bool isSelected = greeting == currentGreeting;

    return Row(
      children: [
        Radio<String>(
          value: greeting,
          groupValue: currentGreeting,
          onChanged: (String? newValue) async {
            if (newValue != null) {
              bool isAuthenticated =
                  await showAuthenticationErrorCard(context, ref);
              if (isAuthenticated) {
                await ref
                    .read(userViewModelProvider.notifier)
                    .updatePreferredGreeting(newValue);
              }
            }
          },
        ),
        Text(
          greeting,
          style: TextStyle(
            fontSize: isSelected ? 15 : 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
