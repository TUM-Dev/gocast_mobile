/// Course model
///
/// A model class to represent a course.
/// This Model is a temporary model to display the course list.
/// This model will be replaced by the actual model class once the API for retrieving
/// the course list is ready.
class CourseModel {
  final String title;
  final String subtitle;
  final String imagePath;
  final bool courseIsLive;

  CourseModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.courseIsLive,
  });
}
