import 'dart:math';

import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

/// This class contains mock data for testing and development purposes.
/// It is used to simulate the API responses.
/// It is not used in production.
/// It will be used for Testing, Demo and Development purposes only.
///
/// This class will be moved to testing folder in the Future.
class MockData {
  static final _random = Random();
  static const String mockEmail = 'ge123abc';
  static const String mockPassword = 'secure';
  static final List<UserSetting> mockUserSettings = mockUser.settings;
  static final List<Course> mockCourses = _defaultCourses();
  static final List<Course> mockUserCourses = _mockUserCoursesDefault(3);
  static final List<Course> mockUserPinned = _mockPinCoursesDefault(2);
  static final List<Course> mockPublicCourses = mockCourses;
  static final List<Course> liveCourses = mockCourses
      .where((course) => course.streams.any((stream) => stream.liveNow))
      .toList();
  static final List<Course> mockDownloadedCourses = _mockDownloadedCourses(2);
  static final List<String> messages = [
    'Hello, welcome to the lecture!',
    'Can you explain this topic further?',
    'Sure, let me elaborate on that.',
    'I have a question about the homework, do we calculate this using the formula from the lecture?',
  ];

  static List<Course> _defaultCourses() {
    // Generate courses without considering liveNow status
    List<Course> courses = List.generate(10, (_) => _generateRandomCourse());

    // Randomly select 1 or 2 courses to be live
    int liveCoursesCount = _random.nextBool() ? 1 : 2;
    List<int> liveIndices = List.generate(courses.length, (index) => index)
      ..shuffle();
    liveIndices.take(liveCoursesCount).forEach((index) {
      courses[index] = _makeCourseLive(courses[index]);
    });

    return courses;
  }

  static List<Course> _mockUserCoursesDefault(int count) {
    if (count >= mockCourses.length) {
      return List<Course>.from(mockCourses);
    }
    var shuffledCourses = List<Course>.from(mockCourses)..shuffle();
    return shuffledCourses.take(count).toList();
  }

  static List<Course> _mockPinCoursesDefault(int count) {
    if (count >= mockUserCourses.length) {
      return List<Course>.from(mockCourses);
    }
    var shuffledCourses = List<Course>.from(mockUserCourses)..shuffle();
    return shuffledCourses.take(count).toList();
  }

  /* static List<Course> _mockPublicCoursesDefault(int count) {
    if (count >= mockCourses.length) {
      return List<Course>.from(mockCourses);
    }
    var shuffledCourses = List<Course>.from(mockCourses)..shuffle();
    return shuffledCourses.take(count).toList();
  }*/

  static List<Course> _mockDownloadedCourses(int count) {
    if (count >= mockUserCourses.length) {
      return List<Course>.from(mockCourses);
    }
    var shuffledCourses = List<Course>.from(mockUserCourses)..shuffle();
    return shuffledCourses.take(count).toList();
  }

  static final User mockUser = User(
    id: 1,
    email: mockEmail,
    name: 'Max',
    lastName: 'Mustermann',
    role: 4,
    settings: [
      UserSetting(
        type: UserSettingType.PREFERRED_NAME,
        value: 'The Boss',
      ),
      UserSetting(
        type: UserSettingType.GREETING,
        value: 'Moin',
      ),
    ],
  );

  static Course _generateRandomCourse() {
    // Generating a unique course name
    String topic = _topics[_random.nextInt(_topics.length)];
    String adjective = _adjectives[_random.nextInt(_adjectives.length)];
    String format = _formats[_random.nextInt(_formats.length)];
    String courseName = '$adjective $topic $format';
    String prefix = _random.nextBool() ? 'IN0' : 'CIT0';
    int number =
        _random.nextInt(900) + 100; // Generates a number from 100 to 999
    String courseSlug = '$prefix$number';
    // Constructing a slug
    // Other attributes
    String playlistUrl =
        'assets/sample.mp4'; // Replace with actual playlist URL'https://zdf-hls-15.akamaized.net/hls/live/2016498/de/high/master.m3u8'
    bool vodEnabled = _random.nextBool();
    String cameraPresetPreferences = _random.nextBool() ? 'HD' : 'SD';
    bool liveNow = false;

    return Course(
      name: courseName,
      slug: courseSlug,
      // imagePath: AppImages.course1, // Uncomment and set accordingly
      vODEnabled: vodEnabled,
      cameraPresetPreferences: cameraPresetPreferences,
      semester: Semester(
        year: _random.nextInt(5) + 2020, // Random year between 2018 and 2022
        teachingTerm: _random.nextBool() ? 'Winter' : 'Summer',
      ),
      streams: [
        Stream(
          name: 'Lecture',
          playlistUrl: playlistUrl,
          liveNow: liveNow,
        ),
        Stream(
          name: 'Tutorial',
          playlistUrl: playlistUrl,
          liveNow: liveNow,
        ),
      ],
    );
  }

  static Course _makeCourseLive(Course course) {
    // Clone the course with one of its streams set to liveNow
    return Course(
      // Copy all existing fields
      name: course.name,
      slug: course.slug,
      // imagePath: course.imagePath, // Uncomment and set accordingly
      vODEnabled: course.vODEnabled,
      cameraPresetPreferences: course.cameraPresetPreferences,
      semester: course.semester,
      streams: course.streams
          .map(
            (stream) => Stream(
          name: stream.name,
          playlistUrl: stream.playlistUrl,
          liveNow: true,
        ),
      )
          .toList(),
    );
  }

  static const List<String> _topics = [
    'Quantum Mechanics',
    'Software Engineering',
    'UI/UX Design',
    'Artificial Intelligence',
    'Machine Learning',
    'Data Science',
    'Computer Vision',
    'Robotics',
    'Computer Graphics',
  ];

  static const List<String> _adjectives = [
    'Advanced',
    'Introductory',
    'Applied',
    'Conceptual',
  ];

  static const List<String> _formats = [
    'Workshop',
    'Seminar',
    'Lecture Series',
    'Lab',
    'Tutorial',
  ];

  static const List<String> _courseNumbers = [
    'IN2023',
    'IN0009',
    'MA1037',
    'CS3021',
    'IN1009',
    'MA2037',
  ];
}