import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/chat_handler.dart';

import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/chat/chat_state_model.dart';

class ChatViewModel extends StateNotifier<ChatState> {
  final GrpcHandler _grpcHandler;

  ChatViewModel(this._grpcHandler) : super(const ChatState());

  Future<void> fetchChatMessages(int streamId) async {
    state = state.copyWith(isLoading: true);
    state = state.clearError();
    try {
      final messages =
          await ChatHandlers(_grpcHandler).getChatMessages(streamId);
      state = state.copyWith(
        messages: messages,
        isLoading: false,
        accessDenied: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e as AppError,
        isLoading: false,
        accessDenied: true,
      );
    }
  }

  Future<void> updateMessages(int streamId) async {
    state = state.copyWith(isLoading: true);
    state = state.clearError();
    if (state.messages == null) {
      fetchChatMessages(streamId);
    } else {
      try {
        final messages =
            await ChatHandlers(_grpcHandler).getChatMessages(streamId);
        final combinedMessages = List<ChatMessage>.from(state.messages ?? [])
          ..addAll(
            messages
                .where((newMessage) => !state.messages!.contains(newMessage)),
          );
        state = state.copyWith(
          messages: combinedMessages,
          isLoading: false,
          accessDenied: false,
        );
      } catch (e) {
        state = state.copyWith(
          error: e as AppError,
          isLoading: false,
          accessDenied: true,
        );
      }
    }
  }

  Future<void> postChatMessage(int streamId, String message) async {
    try {
      fetchChatMessages(streamId);
      var chatMessage =
          await ChatHandlers(_grpcHandler).postChatMessage(streamId, message);
      state = state.addMessage(chatMessage);
    } catch (e) {
      if (_isRateLimitError(e)) {
        state = state.copyWith(isRateLimitReached: true);
        await Future.delayed(const Duration(seconds: 10));
        if (mounted) {
          state = state.copyWith(isRateLimitReached: false);
        }
      } else if (_isCoolDownError(e)) {
        state = state.copyWith(isCoolDown: true);
        await Future.delayed(const Duration(seconds: 30));
        if (mounted) {
          state = state.copyWith(isCoolDown: false);
        }
      } else {
        state = state.copyWith(error: e as AppError);
      }
    }
  }

  Future<void> postMessageReaction(
    int messageId,
    int streamId,
    String emoji,
  ) async {
    try {
      var reaction = await ChatHandlers(_grpcHandler)
          .postMessageReaction(messageId, streamId, emoji);
      state = state.addReaction(reaction);
    } catch (e) {
      state = state.copyWith(error: e as AppError);
    }
  }

  Future<void> deleteMessageReaction(
    int messageId,
    int streamId,
    int reactionId,
  ) async {
    try {
      await ChatHandlers(_grpcHandler)
          .deleteMessageReaction(messageId, streamId, reactionId);
    } catch (e) {
      state = state.copyWith(error: e as AppError);
    }
  }

  Future<void> postChatReply(
    int messageId,
    int streamId,
    String message,
  ) async {
    try {
      var replay = await ChatHandlers(_grpcHandler)
          .postChatReply(messageId, streamId, message);
      state = state.addReply(replay);
    } catch (e) {
      state = state.copyWith(error: e as AppError);
    }
  }

  Future<void> markChatMessageAsResolved(int messageId, int streamId) async {
    try {
      await ChatHandlers(_grpcHandler)
          .markChatMessageAsResolved(messageId, streamId);
    } catch (e) {
      state = state.copyWith(error: e as AppError);
    }
  }

  Future<void> markChatMessageAsUnresolved(int messageId, int streamId) async {
    try {
      await ChatHandlers(_grpcHandler)
          .markChatMessageAsUnresolved(messageId, streamId);
    } catch (e) {
      state = state.copyWith(error: e as AppError);
    }
  }

  void clearError() {
    state = state.clearError();
  }

  bool _isRateLimitError(dynamic error) {
    return error.toString().contains("posting too fast");
  }

  bool _isCoolDownError(dynamic error) {
    return error.toString().contains("cooled down");
  }
}
