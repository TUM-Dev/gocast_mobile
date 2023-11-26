import 'package:gocast_mobile/models/course/bookmark_model.dart';
import 'package:gocast_mobile/models/course/course_model.dart';
import 'package:gocast_mobile/models/user/user_settings_model.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart'
    as proto;

class User {
  User({
    required this.id,
    required this.name,
    required this.lastName,
    this.email = '',
    this.matriculationNumber = '',
    this.lrzID = '',
    this.role = 3,
    required this.courses,
    required this.administeredCourses,
    required this.pinnedCourses,
    required this.settings,
    required this.bookmarks,
  });

  int id;
  String name;
  String lastName;
  String email;
  String matriculationNumber;
  String lrzID;
  int role;
  List<Course> courses;
  List<Course> administeredCourses;
  List<Course> pinnedCourses;
  List<UserSetting> settings;
  List<Bookmark> bookmarks;

  // Factory method to create a User instance from the gRPC response
  factory User.fromProto(proto.User user) {
    return User(
      id: user.id,
      name: user.name,
      lastName: user.lastName,
      email: user.email,
      matriculationNumber: user.matriculationNumber,
      lrzID: user.lrzID,
      role: user.role,
      courses: user.courses
          .map((courseProto) => Course.fromProto(courseProto))
          .toList(),
      administeredCourses: user.administeredCourses
          .map((courseProto) => Course.fromProto(courseProto))
          .toList(),
      pinnedCourses: user.pinnedCourses
          .map((courseProto) => Course.fromProto(courseProto))
          .toList(),
      settings: user.settings
          .map((settingProto) => UserSetting.fromProto(settingProto))
          .toList(),
      bookmarks: user.bookmarks
          .map((bookmarkProto) => Bookmark.fromProto(bookmarkProto))
          .toList(),
    );
  }
}
