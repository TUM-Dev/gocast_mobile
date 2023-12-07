import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:gocast_mobile/views/settings_view/settings_screen_view.dart';
import 'package:gocast_mobile/views/video_view/video_fullscreen_view.dart';

class VideoPlayerCard extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String date;

  const VideoPlayerCard({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.date,
  });

  @override
  VideoPlayerCardState createState() => VideoPlayerCardState();
}

class VideoPlayerCardState extends State<VideoPlayerCard> {
  late VideoPlayerController _controller;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _buildVideoPlayer(),
          _buildControlRow(),
          // Additional content below
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('iPraktikum'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => _navigateToScreen(context, const SettingsScreen()),
        ),
      ],
    );
  }

  Widget _buildVideoPlayer() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(),
        _buildFullScreenButton(),
      ],
    );
  }

  IconButton _buildFullScreenButton() {
    return IconButton(
      icon: const Icon(Icons.fullscreen, color: Colors.white),
      onPressed: _toggleFullScreen,
    );
  }

  Row _buildControlRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
        IconButton(icon: const Icon(Icons.check_circle_outline), onPressed: () {}),
        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      },
      child: Icon(
        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
    );
  }

  void _toggleFullScreen() {
    if (_isFullscreen) {
      Navigator.of(context).pop();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(
          controller: _controller,
          onExitFullscreen: _exitFullScreen,
        ),
      ),
      );
    }
    setState(() => _isFullscreen = !_isFullscreen);
  }

  void _exitFullScreen() {
    Navigator.of(context).pop();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setState(() => _isFullscreen = false);
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
