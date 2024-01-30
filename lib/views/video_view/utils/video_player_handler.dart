import 'dart:ui';

import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class VideoPlayerHandlers {
  final Function(String newPlaylistUrl) switchPlaylist;
  final VoidCallback onToggleChat;
  final VoidCallback onTogglePolls;

  VideoPlayerHandlers({
    required this.switchPlaylist,
    required this.onToggleChat,
    required this.onTogglePolls,
  });

  void handleMenuSelection(String choice, Stream stream) {
    String? playlistUrl;
    switch (choice) {
      case 'Combined view':
        playlistUrl = stream.playlistUrl;
        break;
      case 'Camera view':
        playlistUrl = stream.playlistUrlCAM;
        break;
      case 'Presentation view':
        playlistUrl = stream.playlistUrlPRES;
        break;
    }
    if (playlistUrl != null) {
      switchPlaylist(playlistUrl);
    }
  }

  void handleOpenPolls() {
    onTogglePolls();
  }

  void handleToggleChat() {
    onToggleChat();
  }
}
