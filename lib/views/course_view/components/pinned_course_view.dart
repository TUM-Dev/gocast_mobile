import 'package:flutter/material.dart';

/// PinnedCourseCard
///
/// A card widget representing a pinned course. It displays the course details,
/// including the course title, date, and duration. Users can toggle the pinned state
/// by clicking the pin icon, and tapping the card navigates to the course content.
///
/// Parameters:
///   [imageName] - The asset path or URL of the course image.
///   [title] - The title of the pinned course.
///   [date] - The date or timestamp associated with the course.
///   [duration] - The duration or length of the course.
///   [isPinned] - A boolean indicating whether the course is currently pinned.
///   [onPinToggle] - A callback function triggered when the user toggles the pin icon.
///   [onTap] - A callback function triggered when the user taps the card to view the course content.
///
class PinnedCourseCard extends StatelessWidget {
  final String imageName;
  final String title;
  final String date;
  final String duration;
  final bool isPinned;
  final VoidCallback onPinToggle;
  final VoidCallback onTap;

  const PinnedCourseCard({
    super.key,
    required this.imageName,
    required this.title,
    required this.date,
    required this.duration,
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
                        title,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        date,
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
