import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/poll_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/poll/poll_state_model.dart'; // Make sure to create this file

class PollViewModel extends StateNotifier<PollState> {
  final GrpcHandler _grpcHandler;

  PollViewModel(this._grpcHandler) : super(const PollState());

  Future<void> fetchPolls(int streamId) async {
    state = state.copyWith(isLoading: true);
    state = state.clearError();
    try {
      final polls = await PollHandlers(_grpcHandler).getPolls(streamId);
      state = state.copyWith(polls: polls, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e as AppError, isLoading: false);
    }
  }

  Future<void> postPollVote(int streamId, int pollOptionId) async {
    try {
      await PollHandlers(_grpcHandler).postPollVote(streamId, pollOptionId);
    } catch (e) {
      state = state.copyWith(error: e as AppError);
    }
  }

  void postAnsweredPoll(int pollId, int pollOptionId) {
    state = state.addAnsweredPoll(pollId, pollOptionId);
  }

  void getAnsweredPolls() {
    Map<int, int> answeredPolls = {};
    for (var poll in state.polls ?? []) {
      for (var option in poll.pollOptions) {
        if (option.voted) {
          answeredPolls[poll.id] = option.id;
          break;
        }
      }
    }
    state = state.copyWith(answeredPolls: answeredPolls);
  }

  void clearError() {
    state = state.clearError();
  }
}
