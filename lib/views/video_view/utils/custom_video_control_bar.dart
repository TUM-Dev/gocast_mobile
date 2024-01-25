import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomVideoControlBar extends StatelessWidget {
  final VoidCallback onToggleChat;
  final Function(String) onDownload;
  final VoidCallback onOpenQuizzes;
  final Stream currentStream;
  final bool isChatVisible;
  final bool isChatActive;

  const CustomVideoControlBar({
    super.key,
    required this.onToggleChat,
    required this.onOpenQuizzes,
    required this.currentStream,
    this.isChatActive = false,
    this.isChatVisible = false,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    void showDownloadOptions() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.download),
                  title: const Text('Combined'),
                  onTap: () {
                    Navigator.pop(context);
                    onDownload('Combined');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.present_to_all),
                  title: const Text('Presentation Only'),
                  onTap: () {
                    Navigator.pop(context);
                    onDownload('Presentation');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    onDownload('Camera Only');
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    List<Map<String, IconData>> getMenuItems(bool isPinned, bool isDownloaded) {
      List<Map<String, IconData>> items = [
        {'Pin Course': isPinned ? Icons.push_pin : Icons.push_pin_outlined},
        {
          'Download': isDownloaded
              ? Icons.download_done_outlined
              : Icons.download_outlined,
        },
      ];
      return items;
    }

    return Consumer(
      builder: (context, ref, child) {
        final userViewModel = ref.read(userViewModelProvider.notifier);
        final downloadViewModel = ref.read(downloadViewModelProvider.notifier);
        final isPinned = userViewModel.isCoursePinned(currentStream.courseID);
        final isDownloaded =
            downloadViewModel.isStreamDownloaded(currentStream.id);

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: isChatVisible
                        ? Icon(Icons.chat_bubble, color: themeData.primaryColor)
                        : const Icon(Icons.chat_bubble_outline),
                    color: themeData.iconTheme.color,
                    onPressed: isChatActive ? onToggleChat : null,
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
                        ? await ref
                            .read(userViewModelProvider.notifier)
                            .unpinCourse(currentStream.courseID)
                        : await ref
                            .read(userViewModelProvider.notifier)
                            .pinCourse(currentStream.courseID);
                  } else if (choice == 'Download') {
                    showDownloadOptions();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return getMenuItems(isPinned, isDownloaded)
                      .map((Map<String, IconData> choice) {
                    String text = choice.keys.first;
                    IconData icon = choice.values.first;

                    return PopupMenuItem<String>(
                      value: text,
                      child: ListTile(
                        leading: Icon(icon, color: themeData.iconTheme.color),
                        title: Text(
                          text,
                          style: TextStyle(
                            color: themeData.textTheme.titleMedium?.color,
                          ),
                        ),
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
                elevation:
                    Theme.of(context).platform == TargetPlatform.iOS ? 0 : 3.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
