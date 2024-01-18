import 'dart:io';

import 'package:chewie/chewie.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class OfflineVideoPlayerControllerManager {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  final String localPath;

  OfflineVideoPlayerControllerManager({
    required this.localPath,
  }) {
    videoPlayerController =
        _createVideoPlayerController(localPath);
  }

  VideoPlayerController _createVideoPlayerController(String source) {
    return VideoPlayerController.file(
      File(source),
    );
  }

  Future<void> initializePlayer() async {
    final file = File(localPath);
    if (!await file.exists()) {
      // Handle the case where the video file doesn't exist
      //print('Video file does not exist at path: $localPath');
      return;
    }
    //print('Video file  exist at path: $localPath');

    videoPlayerController = _createVideoPlayerController(localPath);
    await videoPlayerController.initialize();
    chewieController = _createChewieController();
  }
  ChewieController _createChewieController() {
    return ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoPlay: false,
      looping: false,
      cupertinoProgressColors: _getCupertinoProgressColors(),
      materialProgressColors: _getMaterialProgressColors(),
      placeholder: Container(color: Colors.black),
      autoInitialize: true,
      allowFullScreen: true,
      fullScreenByDefault: false,
      showOptions: true,
    );
  }

  ChewieProgressColors _getCupertinoProgressColors() {
    return ChewieProgressColors(
      playedColor: Colors.blue,
      handleColor: Colors.blueAccent,
      backgroundColor: Colors.grey,
      bufferedColor: Colors.lightBlueAccent,
    );
  }

  ChewieProgressColors _getMaterialProgressColors() {
    return ChewieProgressColors(
      playedColor: Colors.blue,
      handleColor: Colors.blueAccent,
      backgroundColor: Colors.grey,
      bufferedColor: Colors.lightBlueAccent,
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
