import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/stream_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/video/stream_state_model.dart';
import 'package:gocast_mobile/utils/sort_utils.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';

class StreamViewModel extends StateNotifier<StreamState> {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  StreamViewModel(this._grpcHandler) : super(const StreamState());

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
    var fetchThumbnailTasks = <Future<Tuple2<Stream, String>>>[];
    for (var stream in state.streams!) {
      fetchThumbnailTasks.add(
        fetchThumbnailForStream(stream)
            .then((thumbnail) => Tuple2(stream, thumbnail)),
      );
    }

    var fetchedStreamsWithThumbnails = await Future.wait(fetchThumbnailTasks);
    state = state.copyWith(
      streamsWithThumb: fetchedStreamsWithThumbnails,
      isLoading: false,
    );
    setUpDisplayedCourses(fetchedStreamsWithThumbnails);
  }

  void updatedDisplayedStreams(List<Tuple2<Stream, String>> allStreams) {
    state = state.copyWith(displayedStreams: allStreams);
  }

  void setUpDisplayedCourses(List<Tuple2<Stream, String>> allStreams) {
    updatedDisplayedStreams(
      CourseUtils.sortStreams(allStreams, state.selectedFilterOption),
    );
  }

  void updateSelectedFilterOption(
    String option,
    List<Tuple2<Stream, String>> allStreams,
  ) {
    state = state.copyWith(selectedFilterOption: option);
    updatedDisplayedStreams(
      CourseUtils.sortStreams(allStreams, state.selectedFilterOption),
    );
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
  Future<String> fetchStreamThumbnail(streamId) async {
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
  Future<String> fetchVODThumbnail(streamId) async {
    try {
      _logger.i('Fetching thumbnail for VOD stream ID: $streamId');
      return await StreamHandler(_grpcHandler).fetchThumbnailVOD(streamId);
    } catch (e) {
      _logger.e('Error fetching thumbnail for VOD stream: $e');
      rethrow;
    }
  }

  Future<void> fetchStream(streamId) async {
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

  Future<void> fetchProgress(streamId) async {
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

  Future<Progress> fetchProgressForStream(streamId) async {
    try {
      final progress =
          await StreamHandler(_grpcHandler).fetchProgress(streamId);
      return progress;
    } catch (e) {
      return Progress(progress: 0.0);
    }
  }

  Future<void> updateProgress(streamId, Progress progress) async {
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

  Future<void> markAsWatched(streamId) async {
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
}
