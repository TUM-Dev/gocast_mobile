/// A ModelGenerator class for generating mock data models.
///
/// This class provides methods to generate random instances of various
/// models like User, Course, UserSetting, and Bookmark for testing and
/// development purposes.
library;

import 'dart:math';
import 'package:gocast_mobile/models/course/bookmark_model.dart';
import 'package:gocast_mobile/models/course/course_model.dart';
import 'package:gocast_mobile/models/user/user_model.dart';
import 'package:gocast_mobile/models/user/user_settings_model.dart';

class ModelGenerator {
  static final _random = Random();

  /// Generate a random unique ID
  static int _uniqueId() => _random.nextInt(10000);

  /// Generate a random teaching term
  static String _randomTeachingTerm() {
    const terms = ['W', 'S'];
    return terms[_random.nextInt(terms.length)];
  }

  /// Generate a random course
  static Course _generateRandomCourse(int index) {
    return Course(
      id: _uniqueId(),
      name: 'Course$index',
      teachingTerm: _randomTeachingTerm(),
      year: _random.nextInt(5) + 2019, // Random year between 2019 and 2023
    );
  }
  /// Generate a random user setting
  static UserSetting _generateRandomUserSetting(int index) {
    return UserSetting(
      id: _uniqueId(),
      userID: _uniqueId(),
      type: UserSettingType.values[_random.nextInt(UserSettingType.values.length)],
      value: 'Value$index',
    );
  }
  /// Generate a random bookmark
  static Bookmark _generateRandomBookmark(int userId, int index) {
    return Bookmark(
      id: _uniqueId(),
      userID: userId,
      description: 'Bookmark $index',
      hours: _random.nextInt(24),
      minutes: _random.nextInt(60),
      seconds: _random.nextInt(60),
      streamID: _random.nextInt(100),
    );
  }

  /// Generate a random user
  static User generateRandomUser() {
    final id = _uniqueId();
    final name = 'User$id';
    final lastName = 'Last$id';
    final email = '$name.$lastName@example.com';
    final matriculationNumber = 'M$id';
    final lrzId = 'L$id';
    final role = _random.nextInt(3) + 1;
    final courses = List.generate(_random.nextInt(5) + 1, _generateRandomCourse);
    final administeredCourses = List.generate(_random.nextInt(3) + 1, _generateRandomCourse);
    final pinnedCourses = List.generate(_random.nextInt(3) + 1, _generateRandomCourse);
    final settings = List.generate(_random.nextInt(3) + 1, _generateRandomUserSetting);
    final bookmarks = List.generate(_random.nextInt(3) + 1, (index) => _generateRandomBookmark(id, index));
    return User(
      id: id,
      name: name,
      lastName: lastName,
      email: email,
      matriculationNumber: matriculationNumber,
      lrzID: lrzId,
      role: role,
      courses: courses,
      administeredCourses: administeredCourses,
      pinnedCourses: pinnedCourses,
      settings: settings,
      bookmarks: bookmarks,
    );
  }
}
