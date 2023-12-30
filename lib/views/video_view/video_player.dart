import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/video_view/chat_video_view.dart';
import 'package:gocast_mobile/views/video_view/video_player_controller.dart';

class VideoPlayerPage extends ConsumerStatefulWidget {
  final String videoSource;
  final VideoSourceType sourceType;
  final String title;
  final Int64 streamId;

  VideoPlayerPage({
    super.key,
    required this.videoSource,
    required this.title,
    required this.streamId,
    VideoSourceType? sourceType,
  }) : sourceType = sourceType ?? _determineSourceType(videoSource);

  @override
  ConsumerState<VideoPlayerPage> createState() => VideoPlayerPageState();

  static VideoSourceType _determineSourceType(String videoSource) {
    return videoSource.startsWith('http')
        ? VideoSourceType.network
        : VideoSourceType.asset;
  }
}

class VideoPlayerPageState extends ConsumerState<VideoPlayerPage> {
  late VideoPlayerControllerManager _controllerManager;
  bool _isLoading = true;
  Timer? _progressTimer; // Define a Timer for progress updates

  @override
  void initState() {
    super.initState();
    _controllerManager = VideoPlayerControllerManager(
      videoSource: widget.videoSource,
      sourceType: widget.sourceType,
    );

    Future.microtask(() async {
      try {
        await ref
            .read(videoViewModelProvider.notifier)
            .fetchProgress(widget.streamId);

        Progress progress = ref.read(videoViewModelProvider).progress ??
            Progress(progress: 0.0);
        await _controllerManager.initializePlayer();
        final position = Duration(
          seconds: (progress.progress *
                  _controllerManager
                      .videoPlayerController.value.duration.inSeconds)
              .round(),
        );
        await _controllerManager.videoPlayerController.seekTo(position);
      } catch (error) {
        if (mounted) {
          setState(() => _isLoading = false);
          // Update the error state outside of setState
          ref
              .read(videoViewModelProvider)
              .copyWith(error: AppError('Failed to load video', error));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    });

    _setupProgressListener();
    _setupCompletionListener();
  }

  @override
  void dispose() {
    _controllerManager.dispose();
    _progressTimer?.cancel();
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

  void _setupProgressListener() {
    _progressTimer =
        Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      if (_controllerManager.videoPlayerController.value.isPlaying) {
        var position = _controllerManager.videoPlayerController.value.position;
        var progress = Progress(
          progress: position.inSeconds /
              _controllerManager.videoPlayerController.value.duration.inSeconds,
          watched: false,
          userID: 4, // replace with actual user ID
          streamID: widget.streamId.toInt(),
        );
        await ref
            .read(videoViewModelProvider.notifier)
            .updateProgress(widget.streamId, progress);
      }
    });
  }

  void _setupCompletionListener() {
    _controllerManager.videoPlayerController.addListener(() {
      if (_controllerManager.videoPlayerController.value.position ==
              _controllerManager.videoPlayerController.value.duration &&
          _controllerManager.videoPlayerController.value.isPlaying) {
        ref
            .read(videoViewModelProvider.notifier)
            .markAsWatched(widget.streamId);
      }
    });
  }
}
