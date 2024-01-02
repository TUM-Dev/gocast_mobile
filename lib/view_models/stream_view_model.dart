import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/stream_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/video/stream_state_model.dart';
import 'package:logger/logger.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';

class StreamViewModel extends StateNotifier<StreamState> {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  StreamViewModel(this._grpcHandler) : super(const StreamState());

  /// This asynchronous function retrieves a list of streams for a given course ID.
  /// Parameters:
  ///   [courseID] - The ID of the course for which streams are to be fetched.
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
}
