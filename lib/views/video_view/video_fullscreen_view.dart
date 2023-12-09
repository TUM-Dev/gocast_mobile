import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final VoidCallback onExitFullscreen;

  const FullScreenVideoPlayer({
    super.key,
    required this.controller,
    required this.onExitFullscreen,
  });

  @override
  FullScreenVideoPlayerState createState() => FullScreenVideoPlayerState();
}

class FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(widget.controller),
              _buildControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (widget.controller.value.isPlaying) {
                    widget.controller.pause();
                  } else {
                    widget.controller.play();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
              onPressed: widget.onExitFullscreen,
            ),
          ],
        ),
       // SizedBox(height: 20),
      ],
    );
  }
}
