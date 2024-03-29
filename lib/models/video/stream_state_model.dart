import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:tuple/tuple.dart';

@immutable
class StreamState {
  final bool isLoading;
  final List<Stream>? streams;
  final List<Stream>? liveStreams;
  final AppError? error;
  final Progress? progress;
  final bool isWatched;
  final String? videoSource;
  final List<Tuple2<Stream, String>>? streamsWithThumb;
  final List<Tuple2<Stream, String>>? liveStreamsWithThumb;
  final List<Tuple2<Stream, String>>? displayedStreams;
  final String selectedFilterOption;

  const StreamState({
    this.isLoading = false,
    this.streams,
    this.liveStreams,
    this.error,
    this.progress,
    this.isWatched = false,
    this.videoSource,
    this.streamsWithThumb,
    this.liveStreamsWithThumb,
    this.displayedStreams,
    this.selectedFilterOption = 'Oldest First',
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
    Map<int, String>? downloadedVideos,
    List<Tuple2<Stream, String>>? streamsWithThumb,
    List<Tuple2<Stream, String>>? liveStreamsWithThumb,
    List<Tuple2<Stream, String>>? displayedStreams,
    String? selectedFilterOption,
  }) {
    return StreamState(
      isLoading: isLoading ?? this.isLoading,
      streams: streams ?? this.streams,
      liveStreams: liveStreams ?? this.liveStreams,
      error: error ?? this.error,
      progress: progress ?? this.progress,
      isWatched: isWatched ?? this.isWatched,
      videoSource: videoSource ?? this.videoSource,
      streamsWithThumb: streamsWithThumb ?? this.streamsWithThumb,
      liveStreamsWithThumb: liveStreamsWithThumb ?? this.liveStreamsWithThumb,
      displayedStreams: displayedStreams ?? this.displayedStreams,
      selectedFilterOption: selectedFilterOption ?? this.selectedFilterOption,
    );
  }

  StreamState clearError() {
    return StreamState(
      isLoading: isLoading,
      streams: streams,
      liveStreams: liveStreams,
      progress: progress,
      isWatched: isWatched,
      videoSource: videoSource,
      streamsWithThumb: streamsWithThumb,
      liveStreamsWithThumb: liveStreamsWithThumb,
      displayedStreams: displayedStreams,
      error: null,
    );
  }

  StreamState switchVideoSource(String videoSource) {
    return StreamState(
      isLoading: isLoading,
      streams: streams,
      liveStreams: liveStreams,
      progress: progress,
      isWatched: isWatched,
      videoSource: videoSource,
      streamsWithThumb: streamsWithThumb,
      liveStreamsWithThumb: liveStreamsWithThumb,
      displayedStreams: displayedStreams,
      error: null,
    );
  }
}
