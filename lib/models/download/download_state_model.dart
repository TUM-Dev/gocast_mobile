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
  final String duration; // Duration in seconds or your preferred unit
  final String description;
  final String date;

  const VideoDetails({
    required this.filePath,
    required this.name,
    required this.duration,
    required this.description,
    required this.date,
  });

  VideoDetails copyWith({
    String? filePath,
    String? name,
    String? duration,
    String? description,
    String? date,
  }) {
    return VideoDetails(
      filePath: filePath ?? this.filePath,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
