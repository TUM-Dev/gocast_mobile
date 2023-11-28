import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart'
    as proto;
import 'package:gocast_mobile/models/error/error_model.dart'; // Import the generated protobuf file

class UserSetting {
  UserSetting({
    required this.id,
    required this.userID,
    required this.type,
    required this.value,
  });

  int id;
  int userID;
  UserSettingType type;
  String value;

  // Factory method to create a UserSetting instance from the gRPC response
  factory UserSetting.fromProto(proto.UserSetting setting) {
    return UserSetting(
      id: setting.id,
      userID: setting.userID,
      type: _getUserSettingType(setting.type as int),
      value: setting.value,
    );
  }

  // Helper method to convert int to UserSettingType enum
  static UserSettingType _getUserSettingType(int typeValue) {
    switch (typeValue) {
      case 0:
        return UserSettingType.preferredName;
      case 1:
        return UserSettingType.greeting;
      case 2:
        return UserSettingType.customPlaybackSpeeds;
      default:
        throw AppError.argumentError(
          'Invalid UserSettingType value: $typeValue',
        );
    }
  }
}

enum UserSettingType {
  preferredName,
  greeting,
  customPlaybackSpeeds,
}
