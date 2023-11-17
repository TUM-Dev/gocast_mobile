import 'package:flutter/foundation.dart';

// ignore_for_file: always_put_required_named_parameters_first
class UserState with ChangeNotifier {
  UserState({
    required this.isLoading,
    required this.user,
    required this.errorMessage,
  });

  bool isLoading;
  User? user;
  String errorMessage;

  void setUser(User? newUser) {
    user = newUser;
    notifyListeners();
  }

  void removeUser() {
    user = null;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
}

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

class Course {
  Course({
    required this.id,
    required this.name,
  });

  int id;
  String name;
}

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

class Bookmark {
  Bookmark({
    required this.id,
    required this.userId,
    required this.title,
    required this.url,
  });

  int id;
  int userId;
  String title;
  String url;
}
