import 'package:flutter/material.dart';

@immutable
class DownloadState {
  final Map<int, String> downloadedVideos;

  const DownloadState({
    this.downloadedVideos = const {},
  });

  DownloadState copyWith({
    Map<int, String>? downloadedVideos,
  }) {
    return DownloadState(
      downloadedVideos: downloadedVideos ?? this.downloadedVideos,
    );
  }
}
