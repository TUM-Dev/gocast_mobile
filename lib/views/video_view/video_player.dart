import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/video_view/chat_video_view.dart';
import 'package:gocast_mobile/views/video_view/video_player_controller.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoSource;
  final VideoSourceType sourceType;
  final String title;

  const VideoPlayerPage({
    super.key,
    required this.videoSource,
    required this.title,
    required this.sourceType,
  });

  @override
  VideoPlayerPageState createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerControllerManager _controllerManager;
  bool _isLoading = true;
  late ValueNotifier<Orientation> _orientationNotifier;

  @override
  void initState() {
    super.initState();
    _controllerManager = VideoPlayerControllerManager(
      videoSource: widget.videoSource,
      sourceType: widget.sourceType,
    );
    _orientationNotifier = ValueNotifier(Orientation.portrait);
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    await _controllerManager.initializePlayer();
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _controllerManager.dispose();
    _orientationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder<Orientation>(
              valueListenable: _orientationNotifier,
              builder: (context, orientation, child) {
                return orientation == Orientation.portrait
                    ? _buildPortraitLayout()
                    : _controllerManager.buildVideoPlayer();
              },
            ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      children: <Widget>[
        Expanded(child: _controllerManager.buildVideoPlayer()),
        const Expanded(child: ChatView()),
      ],
    );
  }

  /// This method is called whenever the orientation of the device changes.
  /// It updates the [_orientationNotifier] with the new orientation.
  /// This is necessary to rebuild the UI when the orientation changes.
  void _onOrientationChange() {
    if (MediaQuery.of(context).orientation != _orientationNotifier.value) {
      _orientationNotifier.value = MediaQuery.of(context).orientation;
    }
  }
}
