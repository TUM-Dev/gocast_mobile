import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/poll_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/poll/poll_state_model.dart'; // Make sure to create this file
import 'package:logger/logger.dart';

class PollViewModel extends StateNotifier<PollState> {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  PollViewModel(this._grpcHandler) : super(const PollState());

  Future<void> fetchPolls(Int64 streamId) async {
    state = state.copyWith(isLoading: true);
    state = state.clearError();
    try {
      final polls = await PollHandlers(_grpcHandler).getPolls(streamId);
      state = state.copyWith(polls: polls, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> postPollVote(Int64 streamId, Int64 pollOptionId) async {
    try {
      await PollHandlers(_grpcHandler).postPollVote(streamId, pollOptionId);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError);
    }
  }

  void clearError() {
    state = state.clearError();
  }
}
