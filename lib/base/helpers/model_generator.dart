import 'dart:math';
import 'package:gocast_mobile/models/course/bookmark_model.dart';
import 'package:gocast_mobile/models/course/course_model.dart';
import 'package:gocast_mobile/models/user/user_model.dart';
import 'package:gocast_mobile/models/user/user_settings_model.dart';

class ModelGenerator {
  static User generateRandomUser() {
    final random = Random();
    final id = random.nextInt(1000);
    final name = 'User$id';
    final lastName = 'Last$id';
    final email = '$name.$lastName@example.com';
    final matriculationNumber = 'M$id';
    final lrzId = 'L$id';
    final role = random.nextInt(3) + 1;
    final courses = List.generate(
      random.nextInt(5) + 1,
      (index) => Course(
        id: index,
        name: 'Course$index',
        teachingTerm: 'W',
        year: 2023,
      ),
    );
    final administeredCourses = List.generate(
      random.nextInt(3) + 1,
      (index) => Course(
        id: index,
        name: 'Course$index',
        teachingTerm: 'W',
        year: 2023,
      ),
    );
    final pinnedCourses = List.generate(
      random.nextInt(3) + 1,
      (index) => Course(
        id: index,
        name: 'Course$index',
        teachingTerm: 'W',
        year: 2023,
      ),
    );
    final settings = List.generate(
      random.nextInt(3) + 1,
      (index) => UserSetting(
        id: index,
        userID: random.nextInt(1000),
        type: UserSettingType.values[random.nextInt(3)],
        value: 'Value$index',
      ),
    );
    final bookmarks = List.generate(
      random.nextInt(3) + 1,
      (index) => Bookmark(
        id: index,
        userID: id,
        description: '',
        hours: 1,
        minutes: 2,
        seconds: 3,
        streamID: 4,
      ),
    );

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
