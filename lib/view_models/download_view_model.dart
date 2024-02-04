import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/download/download_state_model.dart';
import 'package:gocast_mobile/utils/tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class DownloadViewModel extends StateNotifier<DownloadState> {
  final Logger _logger = Logger();

  DownloadViewModel() : super(const DownloadState()) {
    initDownloads();
  }

  bool isStreamDownloaded(int id) {
    final int streamIdInt = id.toInt(); // Convert Int64 to int
    return state.downloadedVideos.containsKey(streamIdInt);
  }

  Future<void> initDownloads() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('downloadedVideos');
    if (jsonString != null) {
      final downloaded = Map<String, dynamic>.from(json.decode(jsonString));
      final downloadedVideos = downloaded.map((key, value) {
        // Decode the JSON string into a Map
        final videoDetailsMap = json.decode(value);
        // Create a VideoDetails object from the Map
        final videoDetails = VideoDetails(
          filePath: videoDetailsMap['filePath'],
          name: videoDetailsMap['name'],
          duration: videoDetailsMap['duration'],
          description: videoDetailsMap['description'],
          date: videoDetailsMap['date'],
        );
        return MapEntry(int.parse(key), videoDetails);
      }).cast<int, VideoDetails>(); // Ensure the map has the correct type
      state = state.copyWith(downloadedVideos: downloadedVideos);
    }
  }

  Future<String> downloadVideo(String videoUrl, Stream stream,
      String streamName, String streamDate) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/${streamName.replaceAll(' ', '_')}.mp4';
      Dio dio = Dio();
      await dio.download(videoUrl, filePath);
      _logger.d('Downloaded video to: $filePath');

      final prefs = await SharedPreferences.getInstance();
      final int streamIdInt = stream.id.toInt();

      // Create a map for the video details
      final videoDetailsMap = {
        'filePath': filePath,
        'name': streamName,
        'duration': Tools.formatDuration(stream.end
            .toDateTime()
            .difference(stream.start.toDateTime())
            .inMinutes),
        'description': stream.description,
        'date': streamDate,
      };

      // Save the JSON string in your SharedPreferences
      final downloadedVideosJson =
          Map<int, VideoDetails>.from(state.downloadedVideos)
            ..[streamIdInt] = VideoDetails.fromJson(videoDetailsMap);

      await prefs.setString(
        'downloadedVideos',
        json.encode(
          downloadedVideosJson.map(
            (key, value) => MapEntry(key.toString(), value),
          ),
        ),
      );

      // Convert the JSON strings back to VideoDetails objects for the state
      final downloadedVideos = downloadedVideosJson.map((key, value) {
        final videoDetailsMap = value.toJson();
        final videoDetails = VideoDetails(
          filePath: videoDetailsMap['filePath'],
          name: videoDetailsMap['name'],
          duration: videoDetailsMap['duration'],
          description: videoDetailsMap['description'],
          date: videoDetailsMap['date'],
        );
        return MapEntry(key, videoDetails);
      }).cast<int, VideoDetails>();

      // Update the state
      state = state.copyWith(downloadedVideos: downloadedVideos);
      _logger.d('Downloaded videos: ${state.downloadedVideos}');
      return filePath;
    } catch (e) {
      _logger.e("Error downloading video: $e");
      return '';
    }
  }

  Future<void> fetchDownloadedVideos() async {
    try {
      _logger.d('Downloaded videos: ${state.downloadedVideos.keys}');
    } catch (e) {
      _logger.e('Error fetching downloaded videos: $e');
    }
  }

  Future<void> deleteDownload(int videoId) async {
    _logger.i('Deleting downloaded video with ID: $videoId');

    try {
      // Get the VideoDetails object from the state
      VideoDetails? videoDetails = state.downloadedVideos[videoId];
      if (videoDetails != null) {
        final filePath = videoDetails.filePath;
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
          _logger.d('Deleted video file at: $filePath');
        } else {
          _logger.w('File not found: $filePath');
        }

        final prefs = await SharedPreferences.getInstance();
        final updatedDownloads = Map<int, VideoDetails>.from(
          state.downloadedVideos,
        );
        updatedDownloads.remove(videoId);

        // Save updated list to SharedPreferences
        // Convert VideoDetails objects to JSON strings before saving
        await prefs.setString(
          'downloadedVideos',
          json.encode(
            updatedDownloads.map(
              (key, value) => MapEntry(key.toString(), json.encode(value)),
            ),
          ),
        );
        state = state.copyWith(downloadedVideos: updatedDownloads);
      }
    } catch (e) {
      _logger.e('Error deleting video with ID $videoId: $e');
    }
  }

  Future<void> deleteAllDownloads() async {
    _logger.i('Deleting all downloaded videos');

    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = Directory(directory.path).listSync();

      for (final file in files) {
        if (file is File && file.path.endsWith('.mp4')) {
          await file.delete();
          _logger.d('Deleted video file at: ${file.path}');
        }
      }

      final prefs = await SharedPreferences.getInstance();
      // Clear the downloaded videos map in SharedPreferences
      await prefs.remove('downloadedVideos');
      // Clear the downloaded videos map in the state
      state = state.copyWith(downloadedVideos: {});
      _logger.i('All downloaded videos have been deleted');
    } catch (e) {
      _logger.e('Error deleting all videos: $e');
    }
  }
}
