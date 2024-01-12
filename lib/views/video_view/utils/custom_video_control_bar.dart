import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomVideoControlBar extends StatelessWidget {
  final Function(Stream stream) onDownloadVideo;
  final VoidCallback onToggleChat;
  final VoidCallback onOpenQuizzes;
  final Stream currentStream;
  final bool isChatVisible;

  const CustomVideoControlBar({
    super.key,
    required this.onDownloadVideo,
    required this.onToggleChat,
    required this.onOpenQuizzes,
    required this.currentStream,
    this.isChatVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    List<Map<String, IconData>> getMenuItems(bool isPinned, bool isDownloaded) {
      List<Map<String, IconData>> items = [
        {'Pin Course': isPinned ? Icons.push_pin : Icons.push_pin_outlined},
        {'Download': isDownloaded ? Icons.download_done_outlined : Icons.download_outlined},
      ];
      return items;
    }

    return Consumer(
      builder: (context, ref, child) {
        final userViewModel = ref.read(userViewModelProvider.notifier);
        final isPinned = userViewModel.isCoursePinned(currentStream.courseID);
        final videoViewModel = ref.read(videoViewModelProvider.notifier);
        final isDownloaded = videoViewModel.isVideoDownloaded(currentStream.id.toInt());

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: isChatVisible ? Icon(Icons.chat_bubble, color: themeData.primaryColor) : const Icon(Icons.chat_bubble_outline),
                    color: themeData.iconTheme.color,
                    onPressed: onToggleChat,
                  ),
                  IconButton(
                    icon: const Icon(Icons.quiz_outlined),
                    color: themeData.iconTheme.color,
                    onPressed: onOpenQuizzes,
                  ),
                ],
              ),
              PopupMenuButton<String>(
                onSelected: (choice) async {
                  if (choice == 'Pin Course') {
                    isPinned
                        ? await ref.read(userViewModelProvider.notifier).unpinCourse(currentStream.courseID)
                        : await ref.read(userViewModelProvider.notifier).pinCourse(currentStream.courseID);
                  } else if (choice == 'Download') {
                      await onDownloadVideo(currentStream);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return getMenuItems(isPinned, isDownloaded).map((Map<String, IconData> choice) {
                    String text = choice.keys.first;
                    IconData icon = choice.values.first;

                    return PopupMenuItem<String>(
                      value: text,
                      child: ListTile(
                        leading: Icon(icon, color: themeData.iconTheme.color),
                        title: Text(text, style: TextStyle(color: themeData.textTheme.titleMedium?.color)),
                      ),
                    );
                  }).toList();
                },
                icon: Icon(Icons.more_vert, color: themeData.iconTheme.color),
                color: themeData.popupMenuTheme.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: themeData.dividerColor),
                ),
                elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0 : 3.0,
              ),
            ],
          ),
        );
      },
    );
  }
}