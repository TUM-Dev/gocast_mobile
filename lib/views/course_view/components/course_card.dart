import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/components/view_all_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// Course card view
///
/// A reusable stateless widget to display a course card.
///
/// It takes a [title], [tumID] and [path] to display the course details.
/// This widget can be reused for various course sections by providing different
/// titles, subtitles and paths.
class CourseCard extends StatelessWidget {
  final String title;
  final String tumID;
  final VoidCallback onTap;
  final int courseId;

  final bool isCourse; //true: course, false: stream
  final WidgetRef? ref;

  //for displaying courses
  final bool? live;
  final String? semester;
  final Course? course;
  final Function(Course)? onPinUnpin;
  final bool? isPinned;

  //for displaying livestreams
  final String? subtitle;
  final String? roomName;
  final String? roomNumber;
  final String? viewerCount;
  final String? path;

  const CourseCard({
    super.key,
    this.ref,
    required this.isCourse,
    required this.title,
    this.subtitle,
    required this.tumID,
    this.roomName,
    this.roomNumber,
    this.viewerCount,
    this.path,
    required this.courseId,
    required this.onTap,
    this.live,
    this.semester,
    this.course,
    this.onPinUnpin,
    this.isPinned,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    double cardWidth = MediaQuery.of(context).size.width >= 600
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.9;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        shadowColor: themeData.shadowColor,
        color: themeData.cardTheme.color,
        // Use card color from theme
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: themeData
                    .inputDecorationTheme.enabledBorder?.borderSide.color
                    .withOpacity(0.2) ??
                Colors.grey.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: isCourse
              ? _buildCourseCard(
                  themeData,
                  cardWidth,
                  context,
                  course!,
                  onPinUnpin!,
                  isPinned!,
                )
              : _buildStreamCard(
                  themeData,
                  cardWidth,
                ),
        ),
      ),
    );
  }

  Widget _buildStreamCard(ThemeData themeData, double cardWidth) {
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(8.0),
      color: themeData.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCourseTumID(),
              _buildCourseViewerCount(themeData),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: _buildCourseImage(),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildCourseTitle(themeData.textTheme),
                    _buildCourseSubtitle(themeData.textTheme),
                    const SizedBox(height: 15),
                    _buildLocation(),
                    //_buildCourseIsLive(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
    ThemeData themeData,
    double cardWidth,
    BuildContext context,
    Course course,
    Function(Course) onPinUnpin,
    bool isPinned,
  ) {
    return Slidable(
      key: ValueKey(course.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        dragDismissible: true,
        children: [
          if (isPinned)
            SlidableAction(
              autoClose: true,
              onPressed: (_) async {
                bool confirmUnpin = await _confirmUnpin(context);
                if (confirmUnpin) onPinUnpin(course);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.push_pin_outlined,
              label: 'Unpin',
            ),
          if (!isPinned)
            SlidableAction(
              autoClose: true,
              onPressed: (_) => onPinUnpin(course),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.push_pin,
              label: 'Pin',
            ),
        ],
      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCourseTumID(),
                        _buildCourseIsLive(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: _buildCourseTitle(themeData.textTheme),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmUnpin(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Unpin'),
              content:
                  const Text('Are you sure you want to unpin this course?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Unpin'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Widget _buildCourseImage() {
    if (path == null) return const SizedBox();
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              path!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        /*Positioned(
          bottom: 3, // Adjust this value based on your layout
          right: 3, // Adjust this value based on your layout
          child: _buildCourseViewerCount(),
        ),*/
      ],
    );
  }

  Widget _buildLocation() {
    if (roomNumber == null) return const SizedBox();

    final Uri url = Uri.parse('https://nav.tum.de/room/$roomNumber');

    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.room,
            size: 20,
          ),
          Text(roomName ?? "Location"),
          //const SizedBox(width: 2),
          Transform.scale(
            scale: 0.6, // Adjust the scale factor as needed
            child: ViewAllButton(onViewAll: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseTumID() {
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

  Widget _buildCourseTitle(TextTheme textTheme) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      //if courses are ever no longer displayed as list, check this for overflows
      softWrap: true,
      style: textTheme.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ) ??
          const TextStyle(),
    );
  }

  Widget _buildCourseSubtitle(TextTheme textTheme) {
    if (subtitle == null) return const SizedBox();

    return Text(
      subtitle!, //nullcheck already passed
      overflow: TextOverflow.ellipsis,
      style: textTheme.labelSmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1,
          ) ??
          const TextStyle(),
    );
  }

  Widget _buildCourseViewerCount(ThemeData themeData) {
    if (viewerCount == null) return const SizedBox();
    return Container(
      decoration: BoxDecoration(
        color: themeData.shadowColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(3),
      child: Text(
        "${viewerCount!} viewers",
        style: themeData.textTheme.labelSmall?.copyWith(
              fontSize: 12,
              height: 1,
            ) ??
            const TextStyle(),
      ),
    );
  }

  Widget _buildCourseIsLive() {
    if (live == null) return const SizedBox();
    return live!
        ? const Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Text(
                'Live Now',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _buildCourseColor() {
    return Container(
      width: 5,
      color: _colorPicker(),
    );
  }

  Color _colorPicker() {
    /** Colors:
     * Informatik - IN: blue
     * Mathe - MA: purple
     * Chemie - CH
     * Physik - PH
     * Maschinenwesen - MW
     * nothing/ other: gray
     * Elektrotechnik - EL
     *
     */
    if (tumID.length < 2) return Colors.grey;
    switch (tumID.substring(0, 2)) {
      case 'IN':
        return Colors.blue;
      case 'MA':
        return Colors.purple;
      case 'CH':
        return Colors.green;
      case 'PH':
        return Colors.orange;
      case 'MW':
        return Colors.red;
      case 'EL':
        return Colors.black87;
      default:
        return Colors.grey;
    }
  }
}
