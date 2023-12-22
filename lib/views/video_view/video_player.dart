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

  @override
  void initState() {
    super.initState();
    _controllerManager = VideoPlayerControllerManager(
      videoSource: widget.videoSource,
      sourceType: widget.sourceType,
    );
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    await _controllerManager.initializePlayer();
    setState(() => _isLoading = false);
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
          : _buildVideoLayout(),
    );
  }

  Widget _buildVideoLayout() {
    return Column(
      children: <Widget>[
        Expanded(child: _controllerManager.buildVideoPlayer()),
        const Expanded(child: ChatView()),
      ],
    );
  }
}
