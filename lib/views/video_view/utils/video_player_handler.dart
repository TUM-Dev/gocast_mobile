import 'dart:ui';

import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class VideoPlayerHandlers {
  final Function(String newPlaylistUrl) switchPlaylist;
  final VoidCallback onToggleChat;

  VideoPlayerHandlers({
    required this.switchPlaylist,
    required this.onToggleChat,
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

  void handleOpenQuizzes() {
    // TODO: Implement quizzes
  }

  void handleToggleChat() {
    onToggleChat();
  }
}
