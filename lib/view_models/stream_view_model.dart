import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/stream_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/video/stream_state_model.dart';
import 'package:logger/logger.dart';

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

  Future<void> fetchStreamThumbnails(Int64 streamId) async {
    _logger.i('Fetching stream thumbnails');
    state = state.copyWith(isLoading: true);
    try {
      final streamThumbnails =
          await StreamHandler(_grpcHandler).fetchThumbnailStreams(streamId);
      state =
          state.copyWith(streamThumbnails: streamThumbnails, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> fetchThumbnailVOD(Int64 streamId) async {
    _logger.i('Fetching live now stream thumbnails');
    state = state.copyWith(isLoading: true);
    try {
      final streamThumbnails =
          await StreamHandler(_grpcHandler).fetchThumbnailVOD(streamId);
      state =
          state.copyWith(streamThumbnails: streamThumbnails, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }
}
