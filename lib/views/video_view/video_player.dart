import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/video_view/chat_video_view.dart';
import 'package:gocast_mobile/views/video_view/custom_video_control_bar.dart';
import 'package:gocast_mobile/views/video_view/video_player_controller.dart';
import 'package:logger/logger.dart';

class VideoPlayerPage extends ConsumerStatefulWidget {
  final Stream stream;

  const VideoPlayerPage({
    super.key,
    required this.stream,
  });

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

  void _downloadVideo(Stream stream) {
    // Define the URL of the video to download
     const videoUrl ="https://file-examples.com/storage/fe15bfb89a659aecba0683a/2017/04/file_example_MP4_480_1_5MG.mp4";
     const String fileName = "downloaded_video.mp4";

    // Call the download function from the StreamViewModel
    ref.read(videoViewModelProvider.notifier)
        .downloadVideo(videoUrl, fileName)
        .then((localPath) {
      if (localPath.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download completed: $localPath')),

        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Download failed')),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _setupProgressListener();
    _setupCompletionListener();
  }

  /// Disposes the video player, completion listener and progress timer.
  @override
  void dispose() {
    _controllerManager.videoPlayerController
        .removeListener(_completionListener);
    _controllerManager.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.stream.name)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildVideoLayout(),
    );
  }

  /// Initializes the video player.
  /// It creates a new instance of `VideoPlayerControllerManager` and initializes it.
  /// It also fetches the progress of the current stream and seeks to the last watched position.
  /// If an error occurs, it sets the error in the current state.
  void _initVideoPlayer() async {
    _controllerManager = VideoPlayerControllerManager(
      videoSource: widget.stream.playlistUrl,
      sourceType:
          VideoPlayerPage._determineSourceType(widget.stream.playlistUrl),
    );
    _setLoadingState(true);
    Future.microtask(() async {
      try {
        var viewModelNotifier = ref.read(videoViewModelProvider.notifier);
        await viewModelNotifier.fetchProgress(widget.stream.id);
        viewModelNotifier.setVideoSource(widget.stream.playlistUrl);
        Progress progress = ref.read(videoViewModelProvider).progress ??
            Progress(progress: 0.0);

        if (!mounted) return;

        await _controllerManager.initializePlayer();

        final position = Duration(
          seconds: (progress.progress *
                  _controllerManager
                      .videoPlayerController.value.duration.inSeconds)
              .round(),
        );

        if (!mounted) return;

        await _controllerManager.videoPlayerController.seekTo(position);

        _setLoadingState(false);
      } catch (error) {
        if (mounted) {
          if (!mounted) return;
          ref
              .read(videoViewModelProvider)
              .copyWith(error: AppError('Failed to load video', error));
          _setLoadingState(
            false,
          ); // Set loading state to false even in case of error
        }
      }
    });
  }

  /// Builds the video layout.
  Widget _buildVideoLayout() {
    return Column(
      children: <Widget>[
        Expanded(child: _controllerManager.buildVideoPlayer()),
        CustomVideoControlBar(
          onMenuSelection: _handleMenuSelection,
          onToggleChat: _toggleChat,
          onOpenQuizzes: _openQuizzes,
          currentStream: widget.stream,
        ),
        const Expanded(child: ChatView()),
      ],
    );
  }

  /// Sets up a timer to update the progress of the current stream.
  /// It sends a `putProgress` gRPC call every 5 seconds.
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
          streamID: widget.stream.id.toInt(),
        );
        await ref
            .read(videoViewModelProvider.notifier)
            .updateProgress(widget.stream.id, progress);
      }
    });
  }

  /// Sets up a listener to mark the current stream as watched when it finishes playing.
  /// It sends a `markAsWatched` gRPC call when the video finishes playing.
  void _setupCompletionListener() {
    _controllerManager.videoPlayerController.addListener(_completionListener);
  }

  // Extracted the listener function for easier removal in dispose
  void _completionListener() {
    if (_controllerManager.videoPlayerController.value.position ==
            _controllerManager.videoPlayerController.value.duration &&
        !_controllerManager.videoPlayerController.value.isPlaying) {
      ref.read(videoViewModelProvider.notifier).markAsWatched(widget.stream.id);
    }
  }

  /// Switches between the different video sources.
  /// It sends a `switchVideoSource` gRPC call to switch between the different video sources.
  void _switchPlaylist(String newPlaylistUrl) async {
    if (ref.read(videoViewModelProvider).videoSource == newPlaylistUrl) {
      Logger().i("Already displaying $newPlaylistUrl");
      return;
    }
    setState(() => _isLoading = true);
    try {
      ref
          .read(videoViewModelProvider.notifier)
          .switchVideoSource(newPlaylistUrl);
      await _controllerManager.switchVideoSource(
        newPlaylistUrl,
        VideoSourceType.network,
      );
      setState(() => _isLoading = false);
    } catch (error) {
      setState(() => _isLoading = false);
      ref
          .read(videoViewModelProvider)
          .copyWith(error: AppError('Failed to load video', error));
    }
  }

  /// Handles menu selections.
  /// It switches between the different video sources or downloads the video.
  void _handleMenuSelection(String choice, Stream stream) {
    if (choice == 'Download') {
      _downloadVideo(stream);

      // TODO: Implement download
    } else if (choice == 'Combined view') {
      _switchPlaylist(stream.playlistUrl);
    } else if (choice == 'Camera view') {
      _switchPlaylist(stream.playlistUrlCAM);
    } else if (choice == 'Presentation view') {
      _switchPlaylist(stream.playlistUrlPRES);
    }
  }

  void _toggleChat() {
    // TODO: Implement chat toggle
  }

  void _openQuizzes() {
    // TODO: Implement quizzes
  }

  // Simplified loading state management
  void _setLoadingState(bool isLoading) {
    if (mounted) {
      setState(() {
        _isLoading = isLoading;
      });
    }
  }
}
