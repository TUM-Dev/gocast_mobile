import 'package:gocast_mobile/models/course/bookmark_model.dart';
import 'package:gocast_mobile/models/course/course_model.dart';
import 'package:gocast_mobile/models/user/user_settings_model.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.lastName,
    this.email = '',
    this.matriculationNumber = '',
    this.lrzId = '',
    this.role = 3,
    this.password = '',
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
  String lrzId;
  int role;
  String password;
  List<Course> courses;
  List<Course> administeredCourses;
  List<Course> pinnedCourses;
  List<UserSetting> settings;
  List<Bookmark> bookmarks;
}
