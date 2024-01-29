import 'dart:async';

import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:logger/logger.dart';

class PollHandlers {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  PollHandlers(this._grpcHandler);

  /// Fetches polls for a stream.
  ///
  /// This method sends a `getPolls` gRPC call to fetch the polls for a stream.
  /// Takes a [streamID] parameter to fetch the polls for a specific stream.
  ///
  /// returns a [List<Poll>] instance that represents the polls for a stream.
  Future<List<Poll>> getPolls(int streamID) async {
    _logger.i('Fetching polls for streamID: $streamID');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response =
            await client.getPolls(GetPollsRequest(streamID: streamID));
        _logger.d('Polls fetched: ${response.polls}');
        return response.polls;
      },
    );
  }

  /// Post a poll vote.
  ///
  /// This method sends a `postPollVote` gRPC call to post a poll vote.
  /// Takes a [streamID] parameter to post a poll vote for a specific stream.
  /// Takes a [pollOptionID] parameter to post a poll vote for a specific poll option.
  Future<void> postPollVote(int streamID, int pollOptionID) async {
    _logger.i(
      'Posting poll vote for streamID: $streamID, pollOptionID: $pollOptionID',
    );
    return _grpcHandler.callGrpcMethod(
      (client) async {
        await client.postPollVote(PostPollVoteRequest(
            streamID: streamID,
            pollOptionID: pollOptionID,
          ),
        );
        _logger.i(
          'Poll vote posted successfully for option $pollOptionID in stream $streamID',
        );
      },
    );
  }
}
