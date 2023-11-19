class UserSetting {
  UserSetting({
    required this.id,
    required this.userId,
    required this.type,
    required this.value,
  });

  int id;
  int userId;
  UserSettingType type;
  String value;
}

enum UserSettingType {
  preferredName,
  greeting,
  customPlaybackSpeeds,
}
