import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/video_view/chat_video_view.dart';
import 'package:gocast_mobile/views/video_view/video_player_controller.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoAssetPath;
  final String title;

  const VideoPlayerPage({
    super.key,
    required this.videoAssetPath,
    required this.title,
  });

  @override
  VideoPlayerPageState createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerControllerManager _controllerManager;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controllerManager =
        VideoPlayerControllerManager(videoAssetPath: widget.videoAssetPath);
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    await _controllerManager.initializePlayer();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controllerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : OrientationBuilder(
              builder: (context, orientation) {
                return orientation == Orientation.portrait
                    ? _buildPortraitLayout()
                    : _buildLandscapeLayout();
              },
            ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5, // Adjust flex ratio to change the space allocation
          child: _controllerManager.buildVideoPlayer(),
        ),
        Expanded(
          flex: 4, // Adjust flex ratio
          child: ChatView(),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return _controllerManager.buildVideoPlayer();
  }
}
