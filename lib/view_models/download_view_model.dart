import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/download/download_state_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'dart:io';

class DownloadViewModel extends StateNotifier<DownloadState> {

  final Logger _logger = Logger();

  DownloadViewModel() : super(const DownloadState()) {
    initDownloads();
  }

  Future<void> initDownloads() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('downloadedVideos');
    if (jsonString != null) {
      final downloaded = Map<String, dynamic>.from(json.decode(jsonString));
      final downloadedVideos = downloaded
          .map((key, value) => MapEntry(int.parse(key), value.toString()));
      state = state.copyWith(downloadedVideos: downloadedVideos);
    }
  }



  Future<String> downloadVideo(
      String videoUrl, int streamId, String fileName,) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      Dio dio = Dio();
      await dio.download(videoUrl, filePath);
      _logger.d('Downloaded video to: $filePath');

      final prefs = await SharedPreferences.getInstance();
      final int streamIdInt = streamId.toInt();
      final downloadedVideos = Map<int, String>.from(state.downloadedVideos)
        ..[streamIdInt] = filePath;

      // Save to SharedPreferences
      await prefs.setString(
          'downloadedVideos',
          json.encode(downloadedVideos
              .map((key, value) => MapEntry(key.toString(), value)),),);
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
    _logger.d('Current state before deletion: ${state.downloadedVideos}');

    try {
      String? filePath = state.downloadedVideos[videoId];
      _logger.d('File path to delete: $filePath');

      if (filePath != null && filePath.isNotEmpty) {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
          _logger.d('Deleted video file at: $filePath');
        } else {
          _logger.w('File not found: $filePath');
        }

        // Update the state and SharedPreferences after deletion
        final updatedDownloads = Map<int, String>.from(state.downloadedVideos);
        updatedDownloads.remove(videoId);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'downloadedVideos',
          json.encode(updatedDownloads.map((key, value) => MapEntry(key.toString(), value))),
        );

        state = state.copyWith(downloadedVideos: updatedDownloads);
        _logger.d('Updated state after deletion: ${state.downloadedVideos}');
      } else {
        _logger.w('No file path found for video ID: $videoId');
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

  bool isStreamDownloaded(int id) {
    final int streamIdInt = id.toInt(); // Convert Int64 to int
    return state.downloadedVideos.containsKey(streamIdInt);
  }
}
