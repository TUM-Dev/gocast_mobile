import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:http/http.dart' as http;

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
            context,
            themeData,
            cardWidth,
          ),
        ),
      ),
    );
  }

  Widget _buildStreamCard(
      BuildContext context, ThemeData themeData, double cardWidth,) {
    return (isDownloaded != null && showDeleteConfirmationDialog != null)
        ? _buildDownloadedCard(context, themeData, cardWidth)
        : _buildLiveCard(themeData, cardWidth);
  }

  Widget _buildDownloadedCard(
      BuildContext context, ThemeData themeData, double cardWidth,) {
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
            label: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),
      child: _buildLiveCard(themeData, cardWidth * 1.3),
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
                    if (!isDownloaded!) _buildLocation(themeData),
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
                : Image.network(
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
    final isLocationEmpty =
        (roomName?.isEmpty ?? true) && (roomNumber?.isEmpty ?? true);

    return isLocationEmpty
        ? _buildInactiveLocation(themeData)
        : _buildActiveLocation(themeData);
  }

  Widget _buildActiveLocation(ThemeData themeData) {
    // Determine the URL based on the availability of roomNumber
    final Uri url = roomNumber?.isNotEmpty ?? false
        ? Uri.parse(
            'https://nav.tum.de/room/$roomNumber',
          ) // Use roomNumber in URL if available
        : Uri.parse(
            'https://nav.tum.de/search?q=${Uri.encodeComponent(roomName ?? '')}',
          ); // Fall back to search URL using roomName

    return Align(
      alignment: Alignment.centerRight,
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
            try {
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            } catch (e) {
              // Handle exceptions or errors here
            }
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.room, size: 24),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInactiveLocation(ThemeData themeData) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.room, size: 24, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
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
