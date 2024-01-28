import 'dart:async';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:logger/logger.dart';

class ChatHandlers {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  ChatHandlers(this._grpcHandler);

  /// Fetches user chats.
  ///
  /// This method sends a `getUserChats` gRPC call to fetch the user's chats.
  /// Takes a [streamID] parameter to fetch the user's chats for a specific stream.
  /// returns a [List<Chat>] instance that represents the user's chats.
  Future<List<ChatMessage>> getChatMessages(int streamID) async {
    return _grpcHandler.callGrpcMethod(
      (client) async {
        _logger.i('Fetching chat messages');
        final response = await client
            .getChatMessages(GetChatMessagesRequest(streamID: streamID));
        _logger.d('Chat messages: ${response.messages}');
        return response.messages;
      },
    );
  }

  /// Post a chat message.
  ///
  /// This method sends a `postChatMessage` gRPC call to post a chat message.
  /// Takes a [streamID] parameter to post a chat message for a specific stream.
  /// Takes a [message] parameter to post a chat message.
  ///
  /// returns a [ChatMessage] instance that represents the posted chat message.
  Future<ChatMessage> postChatMessage(int streamID, String message) async {
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.postChatMessage(
          PostChatMessageRequest(
            streamID: streamID,
            message: message,
          ),
        );
        _logger.i('Chat message posted: ${response.message}');
        return response.message;
      },
    );
  }

  /// Post a message Reaction.
  ///
  /// This method sends a `postChatReaction` gRPC call to post a chat reaction.
  /// Takes a [messageID] parameter to post a chat reaction for a specific message.
  /// Takes a [streamID] parameter to post a chat reaction for a specific stream.
  /// Takes a [emoji] parameter to post a chat reaction.
  ///
  /// returns a [ChatReaction] instance that represents the posted chat reaction.
  Future<ChatReaction> postMessageReaction(int messageID,
      int streamID,
      String emoji,) async {
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.postChatReaction(
          PostChatReactionRequest(
            emoji: emoji,
            streamID: streamID,
            chatID: messageID,
          ),
        );
        _logger.i('Chat reaction ${response.reaction} posted');
        return response.reaction;
      },
    );
  }

  /// Delete a message Reaction.
  ///
  /// This method sends a `deleteChatReaction` gRPC call to delete a chat reaction.
  /// Takes a [messageID] parameter to delete a chat reaction for a specific message.
  /// Takes a [streamID] parameter to delete a chat reaction for a specific stream.
  /// Takes a [reactionID] parameter to delete a chat reaction.
  Future<void> deleteMessageReaction(int messageID,
      int streamID,
      int reactionID,) async {
    return _grpcHandler.callGrpcMethod(
      (client) async {
        await client.deleteChatReaction(
          DeleteChatReactionRequest(
            chatID: messageID,
            streamID: streamID,
            reactionID: reactionID,
          ),
        );
        _logger.i('Chat reaction deleted');
      },
    );
  }

  /// Post a chat reply.
  ///
  /// This method sends a `postChatReply` gRPC call to post a chat reply.
  /// Takes a [messageID] parameter to post a chat reply for a specific message.
  /// Takes a [streamID] parameter to post a chat reply for a specific stream.
  /// Takes a [message] parameter to post a chat reply.
  ///
  /// returns a [ChatMessage] instance that represents the posted chat reply.
  Future<ChatMessage> postChatReply(int messageID,
      int streamID,
      String message,) async {
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.postChatReply(
          PostChatReplyRequest(
            chatID: messageID,
            streamID: streamID,
            message: message,
          ),
        );
        _logger.i('Chat reply ${response.reply} posted');
        return response.reply;
      },
    );
  }

  /// Mark the Chat as resolved.
  ///
  /// This method sends a `markChatMessageAsResolved` gRPC call to mark the chat as resolved.
  /// Takes a [messageID] parameter to mark the chat as resolved for a specific message.
  /// Takes a [streamID] parameter to mark the chat as resolved for a specific stream.
  Future<void> markChatMessageAsResolved(int messageID, int streamID) async {
    return _grpcHandler.callGrpcMethod(
      (client) async {
        await client.markChatMessageAsResolved(
          MarkChatMessageAsResolvedRequest(
            chatID: messageID,
            streamID: streamID,
          ),
        );
        _logger.i('Chat message marked as resolved');
      },
    );
  }

  Future<void> markChatMessageAsUnresolved(int messageID, int streamID) async {
    return _grpcHandler.callGrpcMethod(
      (client) async {
        await client.markChatMessageAsUnresolved(
          MarkChatMessageAsUnresolvedRequest(
            chatID: messageID,
            streamID: streamID,
          ),
        );
        _logger.i('Chat message marked as unresolved');
      },
    );
  }

}