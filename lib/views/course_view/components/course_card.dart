import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gocast_mobile/utils/tools.dart';

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

  const CourseCard._({
    super.key,
    required this.title,
    required this.tumID,
    required this.onTap,
    required this.courseId,
    // Pass other fields as before
    this.live,
    this.course,
    this.onPinUnpin,
    this.isPinned,
    required this.isLoggedIn,
    this.subtitle,
  });

  factory CourseCard({
    Key? key,
    required String title,
    String? subtitle,
    required int courseId,
    required VoidCallback onTap,
    bool? live,
    Course? course,
    Function(Course)? onPinUnpin,
    bool? isPinned,
    required bool isLoggedIn,
  }) {
    final tumID = Tools.extractCourseIds(title);
    return CourseCard._(
      key: key,
      title: title,
      tumID: tumID,
      courseId: courseId,
      onTap: onTap,
      live: live,
      course: course,
      onPinUnpin: onPinUnpin,
      isPinned: isPinned,
      isLoggedIn: isLoggedIn,
      subtitle: subtitle,
    );
  }

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
      endActionPane: isLoggedIn
          ? ActionPane(
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
                    label: AppLocalizations.of(context)!.unpin,
                  ),
                if (!isPinned)
                  SlidableAction(
                    autoClose: true,
                    onPressed: (_) => onPinUnpin(course),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.push_pin,
                    label: AppLocalizations.of(context)!.pin,
                  ),
              ],
            )
          : null,
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
                        _buildCourseIsLive(context),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildCourseTitle(themeData.textTheme),
                          ),
                          if (isPinned)
                            Icon(Icons.push_pin,
                                color: themeData.primaryColor, size: 16),
                        ],
                      ),
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
              title: Text(AppLocalizations.of(context)!.confirm_unpin_title),
              content:
                  Text(AppLocalizations.of(context)!.confirm_unpin_message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(AppLocalizations.of(context)!.unpin),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Widget _buildCourseIsLive(BuildContext context) {
    if (live == null) return const SizedBox();
    return live!
        ? Row(
            children: [
              const Icon(
                Icons.circle,
                size: 10,
                color: Colors.red,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.live_now,
                style: const TextStyle(
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
      color: Tools.colorPicker(tumID),
    );
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
