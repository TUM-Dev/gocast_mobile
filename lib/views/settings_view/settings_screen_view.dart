import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/UserPreferences.dart';
import 'package:gocast_mobile/views/on_boarding_view/welcome_screen_view.dart';
import 'package:gocast_mobile/views/settings_view/playback_speed_settings_view.dart';
import 'package:gocast_mobile/views/settings_view/preferred_greeting_view.dart';
import 'package:gocast_mobile/views/settings_view/edit_profile_screen_view.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/settings_view/authentication_error_card_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

bool _isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= 600;
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(settingViewModelProvider.notifier).fetchUserSettings(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    final settingState = ref.watch(settingViewModelProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: Consumer(
        builder: (context, watch, _) {
          return ListView(
            children: [
              _buildProfileTile(userState),
              const Divider(),
              _buildSectionTitle(
                  AppLocalizations.of(context)!.account_settings),
              _buildEditableListTile(AppLocalizations.of(context)!.edit_profile,
                  () async {
                bool isAuthenticated =
                    await showAuthenticationErrorCard(context, ref);
                if (isAuthenticated && mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                }
              }),
              const PreferredGreetingView(),
              _buildSwitchListTile(
                title: AppLocalizations.of(context)!.push_notifications,
                value: settingState.isPushNotificationsEnabled,
                onChanged: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveNotificationPreference(value);
                },
                ref: ref,
              ),
              _buildThemeSelectionTile(context, ref),
              _buildLanguageSelectionTile(context, ref),
              _buildSwitchListTile(
                title: AppLocalizations.of(context)!.download_over_wifi_only,
                value: settingState.isDownloadWithWifiOnly,
                onChanged: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveDownloadWifiOnlyPreference(value);
                },
                ref: ref,
              ),
              _buildSectionTitle(AppLocalizations.of(context)!.playback_speed),
              const PlaybackSpeedSettings(),
              _buildLogoutTile(context),
              const Divider(),
              _buildSectionTitle(AppLocalizations.of(context)!.more),
              _buildNavigableListTile(
                  AppLocalizations.of(context)!.about_us, ""),
              _buildNavigableListTile(
                AppLocalizations.of(context)!.privacy_policy,
                "https://live.rbg.tum.de/privacy",
              ),
              _buildNavigableListTile(
                AppLocalizations.of(context)!.terms_and_conditions,
                "https://live.rbg.tum.de/imprint",
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.settings),
      leading: IconButton(
        icon: !_isTablet(context)
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  ListTile _buildThemeSelectionTile(BuildContext context, WidgetRef ref) {
    // Get the current theme setting from the state
    final settingState = ref.watch(settingViewModelProvider);

    String themeModeText;
    if (settingState.isDarkMode) {
      themeModeText = AppLocalizations.of(context)!.dark;
    } else if (settingState.isLightMode) {
      themeModeText = AppLocalizations.of(context)!.light;
    } else {
      themeModeText = AppLocalizations.of(context)!.system_default;
    }
    return ListTile(
      title: Text(AppLocalizations.of(context)!.choose_theme),
      subtitle: Text(themeModeText),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showThemeSelectionSheet(context, ref),
    );
  }

  ListTile _buildLanguageSelectionTile(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(AppLocalizations.of(context)!.language_selection),
      subtitle:
          Text(UserPreferences.getLanguageName(UserPreferences.getLanguage())),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () async {
        final selectedLanguage = await showModalBottomSheet<String>(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <String>['en', 'fr', 'de', 'es']
                    .map(
                      (String lang) => ListTile(
                        title: Text(UserPreferences.getLanguageName(lang)),
                        onTap: () => Navigator.pop(context, lang),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        );

        if (selectedLanguage != null) {
          await UserPreferences.setLanguage(selectedLanguage);
          // To rebuild the app
          ref.read(settingViewModelProvider.notifier).setLoading(false);
        }
      },
    );
  }

  void _showThemeSelectionSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text(AppLocalizations.of(context)!.system_default),
                onTap: () {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveThemePreference('system', ref);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.dark),
                onTap: () {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveThemePreference('dark', ref);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.light),
                onTap: () {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .saveThemePreference('light', ref);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile _buildProfileTile(userState) {
    final settingState = ref.watch(settingViewModelProvider);
    final preferredNameSetting = settingState.userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.PREFERRED_NAME,
      orElse: () => UserSetting(value: ''),
    );
    final preferredName = preferredNameSetting?.value ?? '';
    final userName = userState.user?.name ?? 'Guest';

    final greetingSetting = settingState.userSettings?.firstWhere(
      (setting) => setting.type == UserSettingType.GREETING,
      orElse: () => UserSetting(value: 'Hi'),
    );

    final preferredGreeting = greetingSetting?.value ?? 'Hi';
    String displayName = preferredName.isNotEmpty ? preferredName : userName;

    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile_temp.png'),
      ),
      title: Text('$preferredGreeting, $displayName'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  ListTile _buildEditableListTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  ListTile _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required WidgetRef ref,
  }) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        inactiveTrackColor: Theme.of(context).colorScheme.background,
      ),
      onTap: () => onChanged(!value),
    );
  }

  ListTile _buildLogoutTile(BuildContext context) {
    return ListTile(
      title: Text(
        AppLocalizations.of(context)!.logout,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      onTap: () => _showLogoutDialog(context),
    );
  }

  void _showLogoutDialog(BuildContext context) async {
    // Capture the Navigator state before the async gap
    final NavigatorState navigator = Navigator.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.logout),
          content: Text(AppLocalizations.of(context)!.logout_message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              // User chooses not to delete downloads
              child: Text(AppLocalizations.of(context)!.no),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              // User chooses to delete downloads
              child: Text(AppLocalizations.of(context)!.yes),
            ),
          ],
        );
      },
    );
    if (!mounted) return;
    if (result == true) {
      // User decided to delete all downloads
      await ref.read(downloadViewModelProvider.notifier).deleteAllDownloads();
    }
    // Proceed with logout
    ref.read(userViewModelProvider.notifier).logout();
    // Use the captured Navigator state
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  ListTile _buildNavigableListTile(String title, String redirectTo) {
    final Uri url = Uri.parse(redirectTo);

    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }
}
