import 'package:flutter/material.dart';

@immutable
class DownloadState {
  final Map<int, VideoDetails> downloadedVideos;

  const DownloadState({
    this.downloadedVideos = const {},
  });

  DownloadState copyWith({
    required Map<int, VideoDetails> downloadedVideos,
  }) {
    return DownloadState(
      downloadedVideos: downloadedVideos,
    );
  }
}

@immutable
class VideoDetails {
  final String filePath;
  final String name;
  final String duration;
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

  VideoDetails.fromJson(Map<String, dynamic> json)
      : filePath = json['filePath'],
        name = json['name'],
        duration = json['duration'],
        description = json['description'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    'filePath': filePath,
    'name': name,
    'duration': duration,
    'description': description,
    'date': date,
  };


}
