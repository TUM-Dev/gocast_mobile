import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart'; // Assuming Poll is defined here
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class PollState {
  final bool isLoading;
  final List<Poll>? polls;
  final Map<int, int> answeredPolls; // pollId, pollOptionId
  final AppError? error;

  const PollState({
    this.isLoading = false,
    this.polls,
    this.error,
    this.answeredPolls = const {},
  });

  PollState copyWith({
    bool? isLoading,
    List<Poll>? polls,
    Map<int, int>? answeredPolls,
    AppError? error,
    bool? isRateLimitReached,
    bool? accessDenied,
  }) {
    return PollState(
      isLoading: isLoading ?? this.isLoading,
      polls: polls ?? this.polls,
      answeredPolls: answeredPolls ?? this.answeredPolls,
      error: error ?? this.error,
    );
  }

  PollState clearError() {
    return PollState(
      isLoading: isLoading,
      polls: polls,
      answeredPolls: answeredPolls,
      error: null,
    );
  }

  PollState addAnsweredPoll(int pollId, int pollOptionId) {
    // Create a new map from the existing answeredPolls and add the new answered poll
    final updatedAnsweredPolls = Map<int, int>.from(answeredPolls)
      ..[pollId] = pollOptionId;

    // Return a new PollState with the updated map
    return PollState(
      isLoading: isLoading,
      polls: polls,
      answeredPolls: updatedAnsweredPolls,
      error: error,
    );
  }
}
