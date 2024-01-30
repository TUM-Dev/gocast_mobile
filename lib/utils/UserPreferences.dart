import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyLanguage = 'language';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setLanguage(String language) async => await _preferences?.setString(_keyLanguage, language);

  static String getLanguage() => _preferences?.getString(_keyLanguage) ?? 'en';

  static String getLanguageName(String lang) {
    switch (lang) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
    }
    return 'English';
  }
}
