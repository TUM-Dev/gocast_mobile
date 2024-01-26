import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart'; // Assuming Poll is defined here
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class PollState {
  final bool isLoading;
  final List<Poll>? polls;
  final AppError? error;

  const PollState({
    this.isLoading = false,
    this.polls,
    this.error,
  });

  PollState copyWith({
    bool? isLoading,
    List<Poll>? polls,
    AppError? error,
    bool? isRateLimitReached,
    bool? accessDenied,
  }) {
    return PollState(
      isLoading: isLoading ?? this.isLoading,
      polls: polls ?? this.polls,
      error: error ?? this.error,
    );
  }

  PollState clearError() {
    return PollState(
      isLoading: isLoading,
      polls: polls,
      error: null,
    );
  }

  PollState addPoll(Poll poll) {
    final updatedPolls = polls != null ? [...polls!, poll] : [poll];
    return PollState(
      isLoading: isLoading,
      polls: updatedPolls,
      error: error,
    );
  }
}
