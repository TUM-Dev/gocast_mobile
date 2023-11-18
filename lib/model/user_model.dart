// ignore_for_file: always_put_required_named_parameters_first
class UserState {
  UserState({
    required this.isLoading,
    this.user,
    // Placeholder for future helpers (e.g. error handling)
    required this.errorMessage,
  });

  // Default constructor
  UserState.defaultConstructor()
      : isLoading = false,
        errorMessage = '',
        user = null;

  bool isLoading;
  User? user;
  String errorMessage;

  void setUser(User newUser) {
    print("User set to: ${newUser.name}");
    user = newUser;
  }

  void removeUser() {
    user = null;
  }

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void toggleIsLoading() {
    isLoading = !isLoading;
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
