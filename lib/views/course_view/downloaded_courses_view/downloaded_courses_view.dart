import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/download/download_state_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar.dart';
import 'package:gocast_mobile/views/course_view/components/small_stream_card.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_content_view.dart';
import 'package:gocast_mobile/views/video_view/offline_video_player/offline_video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DownloadedCourses extends ConsumerStatefulWidget {
  const DownloadedCourses({super.key});

  @override
  DownloadedCoursesState createState() => DownloadedCoursesState();
}

class DownloadedCoursesState extends ConsumerState<DownloadedCourses> {
  final TextEditingController searchController = TextEditingController();

  void _showDeleteConfirmationDialog(int videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(AppLocalizations.of(context)!.confirm_delete),
          content: Text(AppLocalizations.of(context)!.confirm_delete_message),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.delete),
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss the dialog
                await ref
                    .read(downloadViewModelProvider.notifier)
                    .deleteDownload(videoId);
              },
            ),
          ],
        );
      },
    );
  }

  //TODO: void _handleSortOptionSelected(String choice) {}

  @override
  Widget build(BuildContext context) {
    final downloadedVideos =
        ref.watch(downloadViewModelProvider).downloadedVideos;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(downloadViewModelProvider.notifier)
              .fetchDownloadedVideos();
        },
        child: DownloadCoursesContentView(
          customAppBar: CustomSearchTopNavBar(
            searchController: searchController,
            title: AppLocalizations.of(context)!.download,
            filterOptions: [AppLocalizations.of(context)!.newest_first, AppLocalizations.of(context)!.oldest_first],
            onClick: (String choice) {
              // Handle filter option click
            },
          ),
          videoCards: downloadedVideos.entries.map((entry) {
            final int videoId = entry.key;
            final VideoDetails videoDetails = entry.value;
            final String localPath = videoDetails.filePath;
            final String videoName = videoDetails.name;
            final int durationSeconds = videoDetails.duration;
            final String formattedDuration = "${(durationSeconds ~/ 3600).toString().padLeft(2, '0')}:${((durationSeconds % 3600) ~/ 60).toString().padLeft(2, '0')}:${(durationSeconds % 60).toString().padLeft(2, '0')}";
            return  SmallStreamCard(
              isDownloaded: true,
                courseId: videoId,
                title: videoName,
                subtitle: formattedDuration,
                tumID: "TUMID",
                showDeleteConfirmationDialog: _showDeleteConfirmationDialog,
                onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(
               builder: (context) =>
               OfflineVideoPlayerPage(localPath: localPath),
               ),
               );
              },
    );
          }).toList(),
        ),
      ),
    );

  }
}