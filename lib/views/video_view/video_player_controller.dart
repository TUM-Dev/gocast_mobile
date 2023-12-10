import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gocast_mobile/utils/theme.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllerManager {
  final String videoAssetPath;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  VideoPlayerControllerManager({required this.videoAssetPath});

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.asset(videoAssetPath);
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoPlay: false,
      looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.primaryColor, // TUM Dark Blue
        handleColor: Color(0xFF98C1D9), // TUM Light Blue
        backgroundColor: Colors.white,
        bufferedColor: Color(0xFFDADADA),
      ),
      placeholder: Container(
        color: AppColors.appBarBackgroundColor,
      ),
    );
  }

  Widget buildVideoPlayer() {
    if (chewieController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Chewie(controller: chewieController!);
  }

  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
  }
}
