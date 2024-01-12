import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/helpers/mock_data.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/chat_view/chat_video_view.dart';
import 'package:gocast_mobile/views/video_view/utils/custom_video_control_bar.dart';
import 'package:gocast_mobile/views/video_view/utils/video_player_handler.dart';
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
}

class VideoPlayerPageState extends ConsumerState<VideoPlayerPage> {
  late VideoPlayerControllerManager _controllerManager;
  late VideoPlayerHandlers _videoPlayerHandlers;

  Timer? _progressTimer;
  bool _isChatVisible = false;

  Widget _buildVideoLayout() {
    _videoPlayerHandlers = VideoPlayerHandlers(
      switchPlaylist: _switchPlaylist,
      onToggleChat: _handleToggleChat,
    );
    return Column(
      children: <Widget>[
        Expanded(child: _controllerManager.buildVideoPlayer()),
        CustomVideoControlBar(
          onToggleChat: _videoPlayerHandlers.handleToggleChat,
          onOpenQuizzes: _videoPlayerHandlers.handleOpenQuizzes,
          currentStream: widget.stream,
          isChatVisible: _isChatVisible,
          onDownloadVideo: _handleDownloadVideo,
        ),
         Expanded(child: ChatView(isActive: _isChatVisible)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerHandlers = VideoPlayerHandlers(
      switchPlaylist: _switchPlaylist,
      onToggleChat: _handleToggleChat,
    );
    _initializeControllerManager();
    Future.microtask(() {
      ref
          .read(videoViewModelProvider.notifier)
          .switchVideoSource(widget.stream.playlistUrl);
      _initVideoPlayer();
      _setupProgressListener();
    });
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
      appBar: AppBar(title: Text(widget.stream.name)),
      body: ref.read(videoViewModelProvider).isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildVideoLayout(),
    );
  }

// Initialize the video player.
  Future<void> _initVideoPlayer() async {
    await _setProgress();
    await _initializeAndSeekPlayer();
  }

// Initialize the controller manager.
  void _initializeControllerManager() {
    _controllerManager = VideoPlayerControllerManager(
      currentStream: widget.stream,
      onMenuSelection: _videoPlayerHandlers.handleMenuSelection,
      ref: ref,
    );
  }

  Future<void> _setProgress() async {
    await ref
        .read(videoViewModelProvider.notifier)
        .fetchProgress(widget.stream.id);
  }

// Initialize the video player and seek to the last progress.
  Future<void> _initializeAndSeekPlayer() async {
    if (!mounted) return;
    try {
      await _controllerManager.initializePlayer();
      _setLoadingState(false);
      await _seekToLastProgress();
    } catch (error) {
      _handleError(error, 'Failed to initialize video player');
    }
  }

// Seek to the last progress.
  Future<void> _seekToLastProgress() async {
    Progress progress =
        ref.read(videoViewModelProvider).progress ?? Progress(progress: 0.0);
    final position = Duration(
      seconds: (progress.progress *
              _controllerManager.videoPlayerController.value.duration.inSeconds)
          .round(),
    );
    await _controllerManager.videoPlayerController.seekTo(position);
  }

// Handle errors and update the UI accordingly.
  void _handleError(Object error, String errorMessage) {
    if (mounted) {
      ref
          .read(videoViewModelProvider)
          .copyWith(error: AppError(errorMessage, error));
      _setLoadingState(false);
    }
  }

  void _setupProgressListener() {
    _progressTimer =
        Timer.periodic(const Duration(seconds: 5), _progressUpdateCallback);
  }

  void _progressUpdateCallback(Timer timer) async {
    if (!_isPlayerInitialized()) return;
    if (_controllerManager.videoPlayerController.value.isPlaying) {
      final position = _getCurrentPosition();
      final progress = _calculateProgress(position);
      await _updateProgress(progress);
      if (_shouldMarkAsWatched(progress)) {
        await _markStreamAsWatched();
      }
    }
  }

  bool _isPlayerInitialized() {
    return _controllerManager.videoPlayerController.value.isInitialized;
  }

  Duration _getCurrentPosition() {
    return _controllerManager.videoPlayerController.value.position;
  }

  double _calculateProgress(Duration position) {
    final duration = _controllerManager.videoPlayerController.value.duration;
    return position.inSeconds / duration.inSeconds;
  }

  Future<void> _updateProgress(double progress) {
    var progressData = Progress(progress: progress);
    return ref
        .read(videoViewModelProvider.notifier)
        .updateProgress(widget.stream.id, progressData);
  }

  bool _shouldMarkAsWatched(double progress) {
    const watchedThreshold = 0.9; // 80%
    return progress >= watchedThreshold;
  }

  Future<void> _markStreamAsWatched() {
    return ref
        .read(videoViewModelProvider.notifier)
        .markAsWatched(widget.stream.id);
  }

  void _switchPlaylist(String newPlaylistUrl) async {
    if (ref.read(videoViewModelProvider).videoSource == newPlaylistUrl) {
      Logger().i("Already displaying $newPlaylistUrl");
      return;
    }
    Logger().i("Switching to $newPlaylistUrl");
    _setLoadingState(true);
    try {
      ref
          .read(videoViewModelProvider.notifier)
          .switchVideoSource(newPlaylistUrl);
      await _controllerManager.switchVideoSource(
        newPlaylistUrl,
        VideoSourceType.network,
      );
      _setLoadingState(false);
    } catch (error) {
      _setLoadingState(false);
      ref
          .read(videoViewModelProvider)
          .copyWith(error: AppError('Failed to load video', error));
    }
  }

  // Simplified loading state management
  void _setLoadingState(bool isLoading) {
    setState(() {
      ref.read(videoViewModelProvider).copyWith(isLoading: isLoading);
    });
  }

  void _handleToggleChat() {
    setState(() {
      _isChatVisible = !_isChatVisible; // Toggle chat visibility
    });
  }

  void _handleDownloadVideo(Stream stream) {
    ref.read(videoViewModelProvider.notifier)
        .downloadVideo(MockData.mockVideoURL, stream.name)
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

}
