import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';

@immutable
class ChatState {
  final bool isLoading;
  final List<ChatMessage>? messages;
  final AppError? error;
  final List<ChatReaction>? reactions;
  final List<ChatMessage>? replies;
  final bool isRateLimitReached;

  const ChatState({
    this.isLoading = false,
    this.messages,
    this.error,
    this.reactions,
    this.replies,
    this.isRateLimitReached = false,
  });

  ChatState copyWith({
    bool? isLoading,
    List<ChatMessage>? messages,
    AppError? error,
    List<ChatReaction>? reactions,
    List<ChatMessage>? replies,
    bool? isRateLimitReached,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      error: error ?? this.error,
      reactions: reactions ?? this.reactions,
      replies: replies ?? this.replies,
      isRateLimitReached: isRateLimitReached ?? this.isRateLimitReached,
    );
  }

  ChatState clearError() {
    return ChatState(
      isLoading: isLoading,
      messages: messages,
      reactions: reactions,
      replies: replies,
      isRateLimitReached: isRateLimitReached,
      error: null,
    );
  }

  ChatState addMessage(ChatMessage message) {
    return ChatState(
      isLoading: isLoading,
      messages: messages != null ? [...messages!, message] : [message],
      reactions: reactions,
      replies: replies,
      isRateLimitReached: isRateLimitReached,
      error: null,
    );
  }

ChatState addReaction(ChatReaction reaction) {
    return ChatState(
      isLoading: isLoading,
      messages: messages,
      reactions: reactions != null ? [...reactions!, reaction] : [reaction],
      replies: replies,
      isRateLimitReached: isRateLimitReached,
      error: null,
    );
  }

  ChatState addReply(ChatMessage reply) {
    return ChatState(
      isLoading: isLoading,
      messages: messages,
      reactions: reactions,
      replies: replies != null ? [...replies!, reply] : [reply],
      isRateLimitReached: isRateLimitReached,
      error: null,
    );
  }
}
