import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class StreamState {
  final bool isLoading;
  final List<Stream>? streams;
  final List<Stream>? liveStreams;
  final List<String>? thumbnails;
  final AppError? error;
  final Progress? progress;
  final bool isWatched;
  final String? videoSource;

  const StreamState({
    this.isLoading = false,
    this.streams,
    this.liveStreams,
    this.thumbnails,
    this.error,
    this.progress,
    this.isWatched = false,
    this.videoSource,
  });

  StreamState copyWith({
    bool? isLoading,
    List<Stream>? streams,
    List<Stream>? liveStreams,
    List<String>? thumbnails,
    AppError? error,
    Progress? progress,
    bool? isWatched,
    String? videoSource,
  }) {
    return StreamState(
      isLoading: isLoading ?? this.isLoading,
      streams: streams ?? this.streams,
      liveStreams: liveStreams ?? this.liveStreams,
      thumbnails: thumbnails ?? this.thumbnails,
      error: error ?? this.error,
      progress: progress ?? this.progress,
      isWatched: isWatched ?? this.isWatched,
      videoSource: videoSource ?? this.videoSource,
    );
  }

  StreamState clearError() {
    return StreamState(
      isLoading: isLoading,
      streams: streams,
      liveStreams: liveStreams,
      thumbnails: thumbnails,
      progress: progress,
      isWatched: isWatched,
      videoSource: videoSource,
      error: null,
    );
  }
}
