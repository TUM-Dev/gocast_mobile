import 'dart:math';
import 'package:gocast_mobile/model/course/bookmark_model.dart';
import 'package:gocast_mobile/model/course/course_model.dart';
import 'package:gocast_mobile/model/user/user_model.dart';
import 'package:gocast_mobile/model/user/user_settings_model.dart';

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
    final password = 'password$id';
    final courses = List.generate(
      random.nextInt(5) + 1,
      (index) => Course(id: index, name: 'Course$index'),
    );
    final administeredCourses = List.generate(
      random.nextInt(3) + 1,
      (index) => Course(id: index, name: 'Administered Course$index'),
    );
    final pinnedCourses = List.generate(
      random.nextInt(3) + 1,
      (index) => Course(id: index, name: 'Pinned Course$index'),
    );
    final settings = List.generate(
      random.nextInt(3) + 1,
      (index) => UserSetting(
        id: index,
        userId: id,
        type: UserSettingType.values[random.nextInt(3)],
        value: 'Value$index',
      ),
    );
    final bookmarks = List.generate(
      random.nextInt(3) + 1,
      (index) => Bookmark(
        id: index,
        userId: id,
        title: 'Bookmark$index',
        url: 'https://example.com/bookmark$index',
      ),
    );

    return User(
      id: id,
      name: name,
      lastName: lastName,
      email: email,
      matriculationNumber: matriculationNumber,
      lrzId: lrzId,
      role: role,
      password: password,
      courses: courses,
      administeredCourses: administeredCourses,
      pinnedCourses: pinnedCourses,
      settings: settings,
      bookmarks: bookmarks,
    );
  }
}
