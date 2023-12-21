import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum VideoSourceType { asset, network }

class VideoPlayerControllerManager {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  VideoPlayerControllerManager({
    required String videoSource,
    VideoSourceType sourceType = VideoSourceType.asset,
  }) {
    videoPlayerController = sourceType == VideoSourceType.asset
        ? VideoPlayerController.asset(videoSource)
        : VideoPlayerController.network(videoSource);
  }

  Future<void> initializePlayer() async {
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoPlay: false,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        bufferedColor: Colors.lightBlueAccent,
      ),
      placeholder: Container(color: Colors.black),
      autoInitialize: true,
      allowFullScreen: true,
      fullScreenByDefault: false,
    );
  }

  Widget buildVideoPlayer() => chewieController == null
      ? const Center(child: CircularProgressIndicator())
      : Chewie(controller: chewieController!);

  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
  }
}
