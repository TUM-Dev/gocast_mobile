import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

/// PinnedCourseCard
///
/// A card widget representing a pinned course. It displays the course details,
/// including the course title, date, and duration. Users can toggle the pinned state
/// by clicking the pin icon, and tapping the card navigates to the course content.
///
/// Parameters:
///   [imageName] - The asset path or URL of the course image.
///   [course] - The course model containing details such as title, date, and duration.
///   [isPinned] - A boolean indicating whether the course is currently pinned.
///   [onPinToggle] - A callback function triggered when the user toggles the pin icon.
///   [onTap] - A callback function triggered when the user taps the card to view the course content.
///
class PinnedCourseCard extends StatelessWidget {
  final String imageName;
  final Course course;
  final bool isPinned;
  final VoidCallback onPinToggle;
  final VoidCallback onTap;

  const PinnedCourseCard({
    super.key,
    required this.imageName,
    required this.course,
    required this.isPinned,
    required this.onTap,
    required this.onPinToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${course.name} - ${course.slug}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${course.semester.year} ${course.semester.teachingTerm}",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: onPinToggle,
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              imageName,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
          ),
        ],
      ),
    );
  }
}
