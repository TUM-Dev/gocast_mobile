import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String tumID;
  final VoidCallback onTap;
  final int courseId;


  //for displaying courses
  final bool? live;

  final Course? course;
  final Function(Course)? onPinUnpin;
  final bool? isPinned;
  final bool isLoggedIn;

  //for displaying livestreams
  final String? subtitle;

  const CourseCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.tumID,
    required this.courseId,
    required this.onTap,
    this.live,
    this.course,
    this.onPinUnpin,
    this.isPinned,
    required this.isLoggedIn,
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
            child: _buildCourseCard(
              themeData,
              cardWidth,
              context,
              course!,
              onPinUnpin!,
              isPinned!,
              isLoggedIn,
                ),
        ),
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
      bool isLoggedIn,
  ) {

    return Slidable(
      key: ValueKey(course.id),
      closeOnScroll: true,
      endActionPane: isLoggedIn ? ActionPane(
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
      ) : null,
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

  Widget _buildCourseTitle(TextTheme textTheme) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      softWrap: true,
      style: textTheme.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ) ??
          const TextStyle(),
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
}
