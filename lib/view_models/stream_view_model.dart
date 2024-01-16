import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/stream_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/video/stream_state_model.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class StreamViewModel extends StateNotifier<StreamState> {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  StreamViewModel(this._grpcHandler) : super(const StreamState());

  Future<String> downloadVideo(String videoUrl, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      Dio dio = Dio();
      await dio.download(videoUrl, filePath);
      _logger.d('Downloaded video to: $filePath'); // Debug statement

      // Debug statement to check if downloads are being updated
      state = state.copyWith(
        downloadedVideos: Map.from(state.downloadedVideos)
          ..[state.streams?.first.id.toInt() ?? -1] = filePath,
      );

      return filePath;
    } catch (e) {
      _logger.e("Error downloading video: $e");
      return '';
    }
  }

  Future<void> fetchDownloadVideos() async {
    state = state.copyWith(isLoading: true);

    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = Directory(directory.path).listSync(); // List all files in the storage directory
      final downloadedVideoPaths = <int, String>{};

      for (final file in files) {
        if (file is File && file.path.endsWith('.mp4')) {
          final fileName = file.uri.pathSegments.last; // Get the file name
          final videoIdStr = fileName.split('_').last.split('.').first;
          final videoId = int.tryParse(videoIdStr);

          if (videoId != null) {
            downloadedVideoPaths[videoId] = file.path;
            _logger.d('Found downloaded video with ID $videoId at: ${file.path}'); // Debug statement
          }
        }
      }

      state = state.copyWith(isLoading: false, downloadedVideos: downloadedVideoPaths);
      _logger.d('Downloaded videos: ${downloadedVideoPaths.keys}'); // Debug statement
    } catch (e) {
      _logger.e('Error fetching downloaded videos: $e');
      state = state.copyWith(isLoading: false);
    }
  }
  Future<void> deleteDownload(int videoId) async {
    _logger.i('Deleting downloaded video with ID: $videoId');
    state = state.copyWith(isLoading: true);

    try {
      String? filePath = state.downloadedVideos[videoId];
      if (filePath != null && filePath.isNotEmpty) {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
          _logger.d('Deleted video file at: $filePath');

          // Update the state by removing the video from the downloadedVideos map
          var updatedDownloads = Map<int, String>.from(state.downloadedVideos);
          updatedDownloads.remove(videoId);
          state = state.copyWith(downloadedVideos: updatedDownloads);
        } else {
          _logger.w('File not found: $filePath');
        }
      } else {
        _logger.w('No file path found for video ID: $videoId');
      }
    } catch (e) {
      _logger.e('Error deleting video with ID $videoId: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }


  Future<void> fetchCourseStreams(int courseID) async {
    _logger.i('Fetching streams');
    state = state.copyWith(isLoading: true);
    try {
      final streams =
          await StreamHandler(_grpcHandler).fetchCourseStreams(courseID);
      state = state.copyWith(streams: streams, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  /// This asynchronous function fetches thumbnails for all available streams in the current state.
  /// only if there are streams in the current state.
  /// It initiates fetching of thumbnails for each stream by invoking `fetchThumbnailForStream`.
  Future<void> fetchThumbnails() async {
    if (state.streams == null) {
      return;
    }
    var fetchThumbnailTasks = state.streams!
        .map((stream) => fetchThumbnailForStream(stream))
        .toList();

    var fetchedThumbnails = await Future.wait(fetchThumbnailTasks);
    state = state.copyWith(thumbnails: fetchedThumbnails, isLoading: false);
  }

  /// Fetches a thumbnail for a given stream.
  /// Parameters:
  ///   [stream] - The stream object for which the thumbnail needs to be fetched.
  Future<String> fetchThumbnailForStream(Stream stream) async {
    try {
      return await (stream.liveNow
          ? fetchStreamThumbnail(stream.id)
          : fetchVODThumbnail(stream.id));
    } catch (e) {
      _logger.e('Error fetching thumbnail for stream ID ${stream.id}: $e');
      return '/thumb-fallback.png'; // Fallback thumbnail
    }
  }

  /// Fetches the thumbnail for a live stream.
  /// Parameters:
  ///   [streamId] - The identifier of the stream.
  Future<String> fetchStreamThumbnail(Int64 streamId) async {
    try {
      _logger.i('Fetching thumbnail for live stream ID: $streamId');
      return await StreamHandler(_grpcHandler).fetchThumbnailStreams(streamId);
    } catch (e) {
      _logger.e('Error fetching thumbnail for live stream: $e');
      rethrow;
    }
  }

  /// Fetches the thumbnail for a recorded stream.
  /// Parameters:
  ///   [streamId] - The identifier of the stream.
  Future<String> fetchVODThumbnail(Int64 streamId) async {
    try {
      _logger.i('Fetching thumbnail for VOD stream ID: $streamId');
      return await StreamHandler(_grpcHandler).fetchThumbnailVOD(streamId);
    } catch (e) {
      _logger.e('Error fetching thumbnail for VOD stream: $e');
      rethrow;
    }
  }

  Future<void> fetchStream(Int64 streamId) async {
    _logger.i('Fetching stream');
    state = state.copyWith(isLoading: true);
    try {
      final stream = await StreamHandler(_grpcHandler).fetchStream(streamId);
      state = state.copyWith(streams: [stream], isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchLiveNowStreams() async {
    _logger.i('Fetching live now stream');
    state = state.copyWith(isLoading: true);
    try {
      final streams = await StreamHandler(_grpcHandler).fetchLiveNowStreams();
      state = state.copyWith(liveStreams: streams, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchProgress(Int64 streamId) async {
    state = state.copyWith(isLoading: true);
    try {
      final progress =
          await StreamHandler(_grpcHandler).fetchProgress(streamId);
      state = state.copyWith(progress: progress, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e as AppError,
        isLoading: false,
        progress: Progress(progress: 0.0),
      );
    }
  }

  Future<void> updateProgress(Int64 streamId, Progress progress) async {
    _logger.i('Updating progress');
    state = state.copyWith(isLoading: true);
    try {
      await StreamHandler(_grpcHandler).putProgress(streamId, progress);
      state = state.copyWith(isLoading: false, progress: progress);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> markAsWatched(Int64 streamId) async {
    _logger.i('Marking stream as watched');
    state = state.copyWith(isLoading: true);
    try {
      await StreamHandler(_grpcHandler).markAsWatched(streamId);
      state = state.copyWith(isLoading: false, isWatched: true);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  void setVideoSource(String videoSource) {
    state = state.copyWith(videoSource: videoSource);
  }

  void clearState() {
    state = const StreamState();
  }

  void clearError() {
    state = state.clearError();
  }

  void resetProgress() {
    state = state.copyWith(progress: null);
  }

  void resetVideoSource() {
    state = state.copyWith(videoSource: null);
  }

  void resetWatched() {
    state = state.copyWith(isWatched: false);
  }

  void resetThumbnails() {
    state = state.copyWith(thumbnails: null);
  }

  void resetStreams() {
    state = state.copyWith(streams: null);
  }

  void switchVideoSource(String newPlaylistUrl) {
    state = state.switchVideoSource(newPlaylistUrl);
  }

  void setProgress(double savedProgress) {
    state = state.copyWith(progress: Progress(progress: savedProgress));
  }

  bool isStreamDownloaded(Int64 id) {
    return state.downloadedVideos.containsKey(id.toInt());
  }
}
