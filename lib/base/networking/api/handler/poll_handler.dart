import 'dart:async';

import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:logger/logger.dart';

class PollHandlers {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  PollHandlers(this._grpcHandler);

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
        // Assuming PostPollVoteResponse doesn't have a field to return, just logging the success
      },
    );
  }
// Add any additional poll-related methods here, similar to the ChatHandlers class
}
