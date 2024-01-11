import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
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
    List<double> playbackSpeeds = _getPlaybackSpeeds();
    return ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoPlay: true,
      looping: false,
      additionalOptions: (context) => _getAdditionalOptions(),
      optionsBuilder: (context, additionalOptions) async {
        await _showOptionsDialog(context, additionalOptions);
      },
      cupertinoProgressColors: _getCupertinoProgressColors(),
      materialProgressColors: _getMaterialProgressColors(),
      placeholder: Container(color: Colors.black),
      autoInitialize: true,
      allowFullScreen: true,
      fullScreenByDefault: false,
      playbackSpeeds: playbackSpeeds.isEmpty ? [0.25, 0.5,0.75, 1, 1.25, 1.5, 1.75, 2] : playbackSpeeds,
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

  Future<void> _showOptionsDialog(
    BuildContext context,
    List<OptionItem> additionalOptions,
  ) async {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final optionsWidgets =
        _buildOptionWidgets(context, additionalOptions, isIOS);

    if (isIOS) {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: optionsWidgets,
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
      );
    } else {
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => SafeArea(
          child: ListView(shrinkWrap: true, children: optionsWidgets),
        ),
      );
    }
  }

  List<Widget> _buildOptionWidgets(
    BuildContext context,
    List<OptionItem> options,
    bool isIOS,
  ) {
    return options.map((option) {
      return isIOS
          ? CupertinoActionSheetAction(
              child: _buildOptionRow(option),
              onPressed: () {
                option.onTap?.call();
                Navigator.pop(context);
              },
            )
          : ListTile(
              leading: Icon(option.iconData),
              title: Text(option.title),
              onTap: () {
                option.onTap?.call();
                Navigator.pop(context);
              },
            );
    }).toList();
  }

  Row _buildOptionRow(OptionItem option) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          option.iconData,
          color: Colors.black87,
          size: 20,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            option.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
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

  Future<void> switchVideoSource(
    String newSource,
    VideoSourceType sourceType,
  ) async {
    await _pauseAndDisposeCurrentPlayer();
    await _initializeNewVideoSource(newSource, sourceType);
  }

  Future<void> _pauseAndDisposeCurrentPlayer() async {
    await videoPlayerController.pause();
    videoPlayerController.dispose();
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
    final userViewModel = ref.read(userViewModelProvider.notifier);
    return userViewModel.parsePlaybackSpeeds();
  }
}
