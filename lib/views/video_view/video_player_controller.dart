import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:video_player/video_player.dart';

enum VideoSourceType { asset, network }

class VideoPlayerControllerManager {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  final Function(String, Stream)? onMenuSelection;
  final Stream currentStream;
  final WidgetRef ref;

  VideoPlayerControllerManager({
    this.onMenuSelection,
    required this.currentStream,
    required this.ref,
  }) {
    videoPlayerController =
        _createVideoPlayerController(currentStream.playlistUrl);
  }

  VideoPlayerController _createVideoPlayerController(String source) {
    VideoSourceType sourceType = _determineSourceType(source);
    return sourceType == VideoSourceType.asset
        ? VideoPlayerController.asset(source)
        : VideoPlayerController.networkUrl(Uri.parse(source));
  }

  VideoSourceType _determineSourceType(String videoSource) {
    return videoSource.startsWith('http')
        ? VideoSourceType.network
        : VideoSourceType.asset;
  }

  Future<void> initializePlayer() async {
    await videoPlayerController.initialize();
    chewieController = _createChewieController();
  }

  ChewieController _createChewieController() {
    return ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoPlay: true,
      looping: false,
      zoomAndPan: true,
      additionalOptions: (context) => _getAdditionalOptions(),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
      isLive: currentStream.liveNow,
      allowMuting: true,
      useRootNavigator: true,
      cupertinoProgressColors: _getCupertinoProgressColors(),
      materialProgressColors: _getMaterialProgressColors(),
      placeholder: Container(color: Colors.black),
      autoInitialize: true,
      allowFullScreen: true,
      fullScreenByDefault: false,
      playbackSpeeds: _filteredPlaybackSpeeds(),
      allowPlaybackSpeedChanging: true,
    );
  }


  List<OptionItem> _getAdditionalOptions() {
    List<OptionItem> items = [];
    if (currentStream.hasPlaylistUrl()) {
      items.add(
        OptionItem(
          onTap: () => onMenuSelection?.call('Combined view', currentStream),
          iconData: Icons.layers,
          title: "Combined view",
        ),
      );
    }
    if (currentStream.hasPlaylistUrlCAM()) {
      items.add(
        OptionItem(
          onTap: () => onMenuSelection?.call('Camera view', currentStream),
          iconData: Icons.camera_alt,
          title: "Camera view",
        ),
      );
    }
    if (currentStream.hasPlaylistUrlPRES()) {
      items.add(
        OptionItem(
          onTap: () =>
              onMenuSelection?.call('Presentation view', currentStream),
          iconData: Icons.present_to_all,
          title: "Presentation view",
        ),
      );
    }
    if (currentStream.hasPlaylistUrlCAM() &&
        currentStream.hasPlaylistUrlPRES()) {
      items.add(
        OptionItem(
          onTap: () => onMenuSelection?.call('Split view', currentStream),
          iconData: Icons.vertical_split_sharp,
          title: "Split view",
        ),
      );
    }
    return items;
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
    videoPlayerController.pause();
    videoPlayerController.dispose();
    chewieController?.dispose();
  }

  Future<void> switchVideoSource(
    String newSource,
    VideoSourceType sourceType,
  ) async {
    await _pauseAndDisposeCurrentPlayer();
    await _initializeNewVideoSource(newSource, sourceType);
  }

  Future<void> _pauseAndDisposeCurrentPlayer() async {
    await videoPlayerController.pause();
    await videoPlayerController.dispose();
    chewieController?.dispose();
  }

  Future<void> _initializeNewVideoSource(
    String newSource,
    VideoSourceType sourceType,
  ) async {
    final oldPosition = videoPlayerController.value.position;
    videoPlayerController = _createVideoPlayerController(newSource);
    await initializePlayer();
    await videoPlayerController.seekTo(oldPosition);
    if (videoPlayerController.value.isPlaying) {
      await videoPlayerController.play();
    } else {
      await videoPlayerController.pause();
    }
  }

  List<double> _getPlaybackSpeeds() {
    final settingViewModel = ref.read(settingViewModelProvider.notifier);
    return settingViewModel.parsePlaybackSpeeds();
  }

  List<double> _filteredPlaybackSpeeds() {
    final playbackSpeeds = _getPlaybackSpeeds();
    var filteredSpeeds = playbackSpeeds.where((speed) => speed <= 2.0).toList();
    return filteredSpeeds.isEmpty ? [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2] : filteredSpeeds;
  }


}
