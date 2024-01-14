import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:logger/logger.dart';

class ChatHandlers {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  ChatHandlers(this._grpcHandler);

Future<List<ChatMessage>> getChatMessages(Int64 streamID) async {
    _logger.i('Fetching chat messages');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response =
            await client.getChatMessages(GetChatMessagesRequest(streamID: streamID));
        _logger.d('Chat messages: ${response.messages}');
        return response.messages;
      },
    );
  }

  Future<ChatMessage> postChatMessage(Int64 streamID, String message) async {
    _logger.i('Posting chat message');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response =
            await client.postChatMessage(PostChatMessageRequest(streamID: streamID, message: message));
        _logger.i('Chat message posted: ${response.message}');
        return response.message;
      },
    );
  }

Future<ChatReaction> postMessageReaction(Int64 messageID, Int64 streamID, String emoji) async {
    _logger.i('Posting chat reaction');
    return _grpcHandler.callGrpcMethod(
      (client) async {
           final response = await client.postChatReaction(PostChatReactionRequest(emoji: emoji, streamID:streamID, chatID: messageID));
        _logger.i('Chat reaction ${response.reaction} posted');
        return response.reaction;
      },
    );
  }

Future<void> deleteMessageReaction(Int64 messageID, Int64 streamID, Int64 reactionID) async {
    _logger.i('Deleting chat reaction');
    return _grpcHandler.callGrpcMethod(
      (client) async {
          await client.deleteChatReaction(DeleteChatReactionRequest(chatID: messageID, streamID: streamID, reactionID: reactionID));
        _logger.i('Chat reaction deleted');
      },
    );
  }

Future<ChatMessage> postChatReply(Int64 messageID, Int64 streamID, String message) async {
    _logger.i('Posting chat reply');
    return _grpcHandler.callGrpcMethod(
      (client) async {
           final response = await client.postChatReply(PostChatReplyRequest(chatID: messageID, streamID: streamID, message: message));
        _logger.i('Chat reply ${response.reply} posted');
        return response.reply;
      },
    );
  }

Future<void> markChatMessageAsResolved(Int64 messageID, Int64 streamID) async {
    _logger.i('Marking chat message as resolved');
    return _grpcHandler.callGrpcMethod(
      (client) async {
           await client.markChatMessageAsResolved(MarkChatMessageAsResolvedRequest(chatID: messageID, streamID: streamID));
        _logger.i('Chat message marked as resolved');
      },
    );
  }

Future<void> markChatMessageAsUnresolved(Int64 messageID, Int64 streamID) async {
    _logger.i('Marking chat message as unresolved');
    return _grpcHandler.callGrpcMethod(
      (client) async {
           await client.markChatMessageAsUnresolved(MarkChatMessageAsUnresolvedRequest(chatID: messageID, streamID: streamID));
        _logger.i('Chat message marked as unresolved');
      },
    );
  }

}