import 'package:flutter/material.dart';

@immutable
class DownloadState {
  final Map<int, VideoDetails> downloadedVideos;

  const DownloadState({
    this.downloadedVideos = const {},
  });

  DownloadState copyWith({
    Map<int, VideoDetails>? downloadedVideos,
  }) {
    return DownloadState(
      downloadedVideos: downloadedVideos ?? this.downloadedVideos,
    );
  }
}

@immutable
class VideoDetails {
  final String filePath;
  final String name;
  final int duration; // Duration in seconds or your preferred unit
  final String description;

  const VideoDetails({
    required this.filePath,
    required this.name,
    required this.duration,
    required this.description,
  });

  VideoDetails copyWith({
    String? filePath,
    String? name,
    int? duration,
  }) {
    return VideoDetails(
      filePath: filePath ?? this.filePath,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      description: description,
    );
  }

// Implement toJson and fromJson if you need to serialize/deserialize the object
}
