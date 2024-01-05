import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class VideoPlayerHandlers {
  final Function(String newPlaylistUrl) switchPlaylist;

  VideoPlayerHandlers({
    required this.switchPlaylist,
  });

  void handleMenuSelection(String choice, Stream stream) {
    if (choice == 'Download') {
      // TODO: Implement download
    } else {
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
  }

  void handleToggleChat() {
    // TODO: Implement chat toggle
  }

  void handleOpenQuizzes() {
    // TODO: Implement quizzes
  }
}
