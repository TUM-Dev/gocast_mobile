import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/chat_view/inactive_view.dart';
import 'package:gocast_mobile/views/video_view/offline_video_player/offline_video_player_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineVideoPlayerPage extends ConsumerStatefulWidget {
  final String localPath;

  const OfflineVideoPlayerPage({
    super.key,
    required this.localPath,
  });

  @override
  ConsumerState<OfflineVideoPlayerPage> createState() =>
      OfflineVideoPlayerPageState();
}

class OfflineVideoPlayerPageState
    extends ConsumerState<OfflineVideoPlayerPage> {
  late OfflineVideoPlayerControllerManager _controllerManager;

  Timer? _progressTimer;

  Widget _buildVideoLayout() {
    return Column(
      children: <Widget>[
        Expanded(child: _controllerManager.buildVideoPlayer()),
        const Expanded(child: InactiveView()),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerManager();
    Future.microtask(() {
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
      appBar: AppBar(title: const Text("Replace me with video Title")),
      body: ref.read(videoViewModelProvider).isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildVideoLayout(),
    );
  }

// Initialize the video player.
  Future<void> _initVideoPlayer() async {
    await _initializeAndSeekPlayer();
  }

// Initialize the controller manager.
  void _initializeControllerManager() {
    _controllerManager =
        OfflineVideoPlayerControllerManager(localPath: widget.localPath);
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
    final prefs = await SharedPreferences.getInstance();
    final progress = prefs.getDouble('progress_${widget.localPath}') ?? 0.0;
    final position = Duration(
      seconds: (progress *
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

  Future<void> _updateProgress(double progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('progress_${widget.localPath}', progress);
  }

  bool _shouldMarkAsWatched(double progress) {
    const watchedThreshold = 0.9; // 90%
    return progress >= watchedThreshold;
  }

  Future<void> _markStreamAsWatched() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('watched_${widget.localPath}', true);
  }

  // Simplified loading state management
  void _setLoadingState(bool isLoading) {
    setState(() {
      ref.read(videoViewModelProvider).copyWith(isLoading: isLoading);
    });
  }
}
