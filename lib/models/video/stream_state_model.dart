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

  const StreamState({
    this.isLoading = false,
    this.streams,
    this.liveStreams,
    this.thumbnails,
    this.error,
  });

  StreamState copyWith({
    bool? isLoading,
    List<Stream>? streams,
    List<Stream>? liveStreams,
    List<String>? thumbnails,
    AppError? error,
  }) {
    return StreamState(
      isLoading: isLoading ?? this.isLoading,
      streams: streams ?? this.streams,
      liveStreams: liveStreams ?? this.liveStreams,
      thumbnails: thumbnails ?? this.thumbnails,
      error: error ?? this.error,
    );
  }

  StreamState clearError() {
    return StreamState(
      isLoading: isLoading,
      streams: streams,
      liveStreams: liveStreams,
      thumbnails: thumbnails,
      error: null,
    );
  }
}
