import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class CustomVideoControlBar extends StatelessWidget {
  final Function(String, Stream) onMenuSelection;
  final VoidCallback onToggleChat;
  final VoidCallback onOpenQuizzes;
  final Stream currentStream;

  const CustomVideoControlBar({
    super.key,
    required this.onMenuSelection,
    required this.onToggleChat,
    required this.onOpenQuizzes,
    required this.currentStream,
  });

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icons on the left
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.messenger_outline_outlined),
                onPressed: onToggleChat,
              ),
              IconButton(
                icon: const Icon(Icons.quiz_outlined),
                onPressed: onOpenQuizzes,
              ),
            ],
          ),

          // Three-dot menu on the right
          PopupMenuButton<String>(
            onSelected: (choice) => onMenuSelection(choice, currentStream),
            itemBuilder: (BuildContext context) {
              return <Map<String, IconData>>[
                {'Download': Icons.file_download},
                {'Combined view': Icons.layers},
                {'Camera view': Icons.camera_alt},
                {'Presentation view': Icons.present_to_all},
              ].map((Map<String, IconData> choice) {
                String text = choice.keys.first;
                IconData icon = choice.values.first;

                return PopupMenuItem<String>(
                  value: text,
                  child: ListTile(
                    leading: Icon(icon),
                    title: Text(text),
                  ),
                );
              }).toList();
            },
            icon: const Icon(Icons.more_vert),
            color: Colors.white,
            // White background
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            elevation: isIOS ? 0 : 3.0, // Adjust elevation based on platform
          ),
        ],
      ),
    );
  }
}
