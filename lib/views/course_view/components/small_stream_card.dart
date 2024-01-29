import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SmallStreamCard extends StatelessWidget {
  final String title;
  final String tumID;
  final VoidCallback onTap;
  final int? courseId;

  //for displaying courses
  final bool? live;
  final bool? isDownloaded;
  final Course? course;
  final Function(int)? showDeleteConfirmationDialog;
  //for displaying livestreams
  final String? subtitle;
  final String? roomName;
  final String? roomNumber;

  final String? path;

  const SmallStreamCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.tumID,
    this.roomName,
    this.roomNumber,
    this.path,
    this.courseId,
    required this.onTap,
    this.live,
    this.course,
    this.isDownloaded,
    this.showDeleteConfirmationDialog,
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
          child: _buildStreamCard(
            themeData,
            cardWidth,
          ),
        ),
      ),
    );
  }

  Widget _buildStreamCard(ThemeData themeData, double cardWidth) {
    return (isDownloaded!=null && showDeleteConfirmationDialog!=null) ? _buildDownloadedCard(themeData, cardWidth) : _buildLiveCard(themeData, cardWidth);
  }

  Widget _buildDownloadedCard (ThemeData themeData, double cardWidth) {
    return Slidable(
        key: Key(courseId.toString()),
        closeOnScroll: true,
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dragDismissible: true,
          children: [
            SlidableAction(
              onPressed: (_) => showDeleteConfirmationDialog!(courseId!),
              autoClose: true,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              label: 'Delete',
            ),
          ],
        ),
        child: _buildLiveCard(themeData, cardWidth*1.3),
    );
  }

  Widget _buildLiveCard(ThemeData themeData, double cardWidth) {
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
                    _buildLocation(themeData),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseImage() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: path == null
                ? Image.asset(
                    AppImages.course1,
                    fit: BoxFit.cover,
                  )
                :
            Image.network(
              path!, // Use the image URL
              fit: BoxFit.cover, // Maintain the cover fit
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image is fully loaded
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppImages.course1,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocation(ThemeData themeData) {
    if (roomNumber == null) return const SizedBox();

    final Uri url = Uri.parse('https://nav.tum.de/room/$roomNumber');

    return Align(
      alignment: Alignment.centerRight, // Align to the right
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: themeData
                    .inputDecorationTheme.enabledBorder?.borderSide.color
                    .withOpacity(0.4) ??
                Colors.grey.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: () async {
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            // Constrain row size to its children
            children: [
              Icon(Icons.room, size: 24),
              SizedBox(width: 8), // Spacing before the arrow icon
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
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
}
