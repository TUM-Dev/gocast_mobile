import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/course_view/components/livenow_card_view.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';

/// CourseSection
///
/// A reusable stateless widget to display a specific course section.
///
/// It takes a [sectionTitle] to display the title of the section and
/// dynamically generates a horizontal list of courses. This widget can be
/// reused for various course sections by providing different titles and
/// course lists.
///
/// This widget also takes an [onViewAll] action to define the action to be
/// performed when the user taps on the View All button.
/// This widget also takes a [courses] list to display the list of courses.
/// If no courses are provided, it will display a default list of courses.
/// This widget can be reused for various course sections by providing
/// different titles, courses and onViewAll actions.
class LivenowSection extends StatelessWidget {
  final String sectionTitle;
  final List<Course>? courses;
  final List<Stream> streams;

  const LivenowSection({
    super.key,
    required this.sectionTitle,
    this.courses,
    List<Stream>? streams, // Changed to nullable List<Stream>
  }) : streams = streams ?? const [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCourseSectionOrMessage(
            context: context,
            title: sectionTitle,
            courses: courses ?? _defaultCourses(),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseSectionOrMessage({
    required BuildContext context,
    required String title,
    required List<Course> courses,
  }) {
    return courses.isNotEmpty
        ? _buildCourseSection(
            context: context,
            title: title,
            courses: courses,
          )
        : _buildNoCoursesMessage(context, title);
  }

  Widget _buildCourseSection({
    required BuildContext context,
    required String title,
    required List<Course> courses,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: streams.length,
              itemBuilder: (BuildContext context, int index) {
                /// Those are temporary values until we get the real data from the API
                final Random random = Random();
                final stream = streams[index];
                final course = courses
                    .where((course) => course.id == stream.courseID)
                    .first;

                String imagePath;
                List<String> imagePaths = [
                  AppImages.course1,
                  AppImages.course2,
                ];
                imagePath = imagePaths[random.nextInt(imagePaths.length)];

                /// End of temporary values
                return LiveNowCard(
                  imageName: imagePath,
                  streamTitle: stream.name,
                  courseTitle: course.name,
                  courseTumID: course.tUMOnlineIdentifier,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //TODO - chat is enabled in live mode
                        builder: (context) => VideoPlayerPage(
                          stream: stream,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildNoCoursesMessage(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust color as per your theme
                ),
              ),
              const Spacer(),
              // This will push the title to the start of the Row
            ],
          ),
          const SizedBox(height: 20), // Spacing between title and icon
          const Center(
            // Center the icon
            child: Icon(Icons.folder_open, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 8), // Spacing between icon and text
          Center(
            child: Text(
              'No $title found',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 12), // Spacing between text and button
          Center(
            // Center the button
            child: ElevatedButton(
              onPressed: () {
                /* Action */
              },
              child: Text(
                _buttonText(title),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buttonText(String title) {
    switch (title) {
      case 'My courses':
        return 'Enroll in a Course';
      case 'livenow':
        return 'No courses currently live';
      case 'Public courses':
        return 'No public courses found';
      default:
        return 'Discover Courses';
    }
  }

  List<Course> _defaultCourses() {
    return [
      Course(
        name: 'PSY101',
        slug: 'Introduction to Psychology',
        //imagePath: AppImages.course1,
        vODEnabled: true,
        cameraPresetPreferences: 'HD',
        semester: Semester(
          year: 2021,
          teachingTerm: 'Fall',
        ),
        streams: [
          Stream(
            name: 'Lecture',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: true,
          ),
          Stream(
            name: 'Tutorial',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: false,
          ),
        ],
      ),
      Course(
        name: 'PSY102',
        slug: 'Introduction to Mathematics',
        //imagePath: AppImages.course2,
        vODEnabled: false,
        cameraPresetPreferences: 'HD',
        semester: Semester(
          year: 2021,
          teachingTerm: 'Fall',
        ),
        streams: [
          Stream(
            name: 'Lecture',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: false,
          ),
          Stream(
            name: 'Tutorial',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: true,
          ),
        ],
      ),
      Course(
        name: 'PSY103',
        slug: 'Introduction to Chemistry',
        //imagePath: AppImages.course2,
        vODEnabled: true,
        cameraPresetPreferences: 'HD',
        semester: Semester(
          year: 2021,
          teachingTerm: 'Fall',
        ),
        streams: [
          Stream(
            name: 'Lecture',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: false,
          ),
          Stream(
            name: 'Tutorial',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: false,
          ),
        ],
      ),
      Course(
        name: 'PSY104',
        slug: 'Introduction to Biology',
        //imagePath: AppImages.course2,
        vODEnabled: true,
        cameraPresetPreferences: 'HD',
        semester: Semester(
          year: 2021,
          teachingTerm: 'Fall',
        ),
        streams: [
          Stream(
            name: 'Lecture',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: false,
          ),
          Stream(
            name: 'Tutorial',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: false,
          ),
        ],
      ),
      Course(
        name: 'PSY105',
        slug: 'Introduction to Physics',
        //imagePath: AppImages.course2,
        vODEnabled: true,
        cameraPresetPreferences: 'HD',
        semester: Semester(
          year: 2021,
          teachingTerm: 'Fall',
        ),
        streams: [
          Stream(
            name: 'Lecture',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: false,
          ),
          Stream(
            name: 'Tutorial',
            playlistUrl:
                'https://www.youtube.com/playlist?list=PL8dPuuaLjXtOPRKzVLY0jJY-uHOH9KVU6',
            liveNow: false,
          ),
        ],
      ),
    ];
  }
}