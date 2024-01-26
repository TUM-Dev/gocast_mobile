import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/download/download_state_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_card.dart';
import 'package:gocast_mobile/views/course_view/downloaded_courses_view/download_content_view.dart';
import 'package:gocast_mobile/views/video_view/offline_video_player/offline_video_player.dart';

class DownloadedCourses extends ConsumerStatefulWidget {
  const DownloadedCourses({super.key});

  @override
  DownloadedCoursesState createState() => DownloadedCoursesState();
}

class DownloadedCoursesState extends ConsumerState<DownloadedCourses> {
  final TextEditingController searchController = TextEditingController();

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
            title: 'Downloads',
            filterOptions: const ['Newest First', 'Oldest First'],
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
            return VideoCard(
              duration:
              formattedDuration,
              imageName: 'assets/images/course1.png',
              // Update as necessary
              title: videoName,
              // Replace with the appropriate title
              date: 'Video Date',
              // Replace with the appropriate date
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        OfflineVideoPlayerPage(localPath: localPath),
                  ),
                );
              },
              onDelete: () async {
                await ref
                    .read(downloadViewModelProvider.notifier)
                    .deleteDownload(videoId);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
