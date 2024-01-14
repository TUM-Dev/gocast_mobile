import 'package:flutter/material.dart';

/// Course card view
///
/// A reusable stateless widget to display a course card.
///
/// It takes a [title], [subtitle] and [path] to display the course details.
/// This widget can be reused for various course sections by providing different
/// titles, subtitles and paths.
class CourseCardText extends StatelessWidget {
  final String title;
  final String tumID;
  final String identifier;
  final String semester;
  final String path;
  final bool live;

  const CourseCardText({
    super.key,
    required this.title,
    required this.tumID,
    required this.identifier,
    required this.semester,
    required this.path,
    required this.live,
    required int courseId,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return InkWell(
      onTap: () {
        // TODO: Add navigation to the course details screen
      },
      child: Card(
        elevation: 1,
        surfaceTintColor: themeData.cardColor,
        shadowColor: Colors.grey.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: themeData
                .inputDecorationTheme.enabledBorder!.borderSide.color
                .withOpacity(0.5), //TODO add check alternatives
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                _buildCourseColor(),
                Expanded(
                  child: Container(
                    color: themeData.cardColor,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCourseSubtitle(),
                        _buildCourseTitle(themeData.textTheme),
                        _buildLastLecture(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLastLecture() { //TODO make responsive
    return Text(
      'Last Lecture: Thursday, 26/10/2023, 10:00',
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12.0,
      ),
    );
  }

  Widget _buildCourseTitle(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 3),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: true,
        style: textTheme.titleMedium?.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 1,
            ) ??
            const TextStyle(),
      ),
    );
  }

  Widget _buildCourseSubtitle() {
    return Text(
      tumID,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
        height: 0.9,
      ),
    );
  }

  Widget _buildCourseColor() {
    return Container(
      width: 5,
      color: _colorPicker(),
    );
  }

  Color _colorPicker() { //TODO what are all the TUM faculties?
    /** Colors:
     * Informatik - IN: blue
     * Mathe - MA: purple
     * Chemie - CH
     * Physik - PH
     * Maschinenwesen - MW
     * nothing/ other: gray
     *
     * Elektrotechnick - EL
     * Management -
     * Engineering
     *
     */
    switch (tumID.substring(0, 2)) {
      case 'IN':
        return Colors.blue;
      case 'MA':
        return Colors.purple;
      case 'CH':
        return Colors.green;
      case 'PH':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
