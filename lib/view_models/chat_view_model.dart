import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/chat_handler.dart';

import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/chat/chat_state_model.dart';
import 'package:logger/logger.dart';

class ChatViewModel extends StateNotifier<ChatState> {
  final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  ChatViewModel(this._grpcHandler) : super(const ChatState());

  Future<void> fetchChatMessages(streamId) async {
    state = state.copyWith(isLoading: true);
    state = state.clearError();
    try {
      final messages =
          await ChatHandlers(_grpcHandler).getChatMessages(streamId);
      state = state.copyWith(messages: messages, isLoading: false);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(
        error: e as AppError,
        isLoading: false,
        accessDenied: true,
      );
    }
  }

  Future<void> postChatMessage(streamId, message) async {
    try {
      fetchChatMessages(streamId);
      var chatMessage =
          await ChatHandlers(_grpcHandler).postChatMessage(streamId, message);
      state = state.addMessage(chatMessage);
    } catch (e) {
      _logger.e(e);
      if (_isRateLimitError(e)) {
        state = state.copyWith(isRateLimitReached: true);
        await Future.delayed(const Duration(seconds: 10));
        if (mounted) {
          state = state.copyWith(isRateLimitReached: false);
        }
      } else if (_isCoolDownError(e)) {
        state = state.copyWith(isCoolDown: true);
        await Future.delayed(const Duration(seconds: 60));
        if (mounted) {
          state = state.copyWith(isCoolDown: false);
        }
      } else {
        state = state.copyWith(error: e as AppError);
      }
    }
  }

  Future<void> postMessageReaction(
    messageId,
    streamId,
    emoji,
  ) async {
    try {
      var reaction = await ChatHandlers(_grpcHandler)
          .postMessageReaction(messageId, streamId, emoji);
      state = state.addReaction(reaction);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError);
    }
  }

  Future<void> deleteMessageReaction(
    messageId,
    streamId,
    reactionId,
  ) async {
    try {
      await ChatHandlers(_grpcHandler)
          .deleteMessageReaction(messageId, streamId, reactionId);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError);
    }
  }

  Future<void> postChatReply(
    messageId,
    streamId,
    message,
  ) async {
    try {
      var replay = await ChatHandlers(_grpcHandler)
          .postChatReply(messageId, streamId, message);
      state = state.addReply(replay);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError);
    }
  }

  Future<void> markChatMessageAsResolved(
    messageId,
    streamId,
  ) async {
    try {
      await ChatHandlers(_grpcHandler)
          .markChatMessageAsResolved(messageId, streamId);
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(error: e as AppError);
    }
  }

  Future<void> markChatMessageAsUnresolved(
    messageId,
    streamId,
  ) async {
    try {
      await ChatHandlers(_grpcHandler)
          .markChatMessageAsUnresolved(messageId, streamId);
    } catch (e) {
      _logger.e(e);
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
