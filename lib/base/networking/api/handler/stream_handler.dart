import 'package:fixnum/fixnum.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:logger/logger.dart';

class StreamHandler {
  static final Logger _logger = Logger();
  final GrpcHandler _grpcHandler;

  StreamHandler(this._grpcHandler);

  /// Fetches the current course streams.
  ///
  /// This method sends a `getUserStreams` gRPC call to fetch the user's
  /// streams.
  ///
  /// Takes [courseID] as a parameter.
  /// Returns a [List<Stream>] instance that represents the user's streams.
  Future<List<Stream>> fetchCourseStreams(int courseID) async {
    _logger.i('Fetching streams');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client
            .getCourseStreams(GetCourseStreamsRequest(courseID: courseID));
        _logger.d('Streams: ${response.streams}');
        return response.streams;
      },
    );
  }

  /// Fetches the stream of the course.
  ///
  /// This method sends a `getStream` gRPC call to fetch the stream of the course.
  ///
  /// Takes [streamId] as a parameter.
  ///
  /// Returns a [Stream] instance that represents the stream of the course.
  Future<Stream> fetchStream(int streamId) async {
    _logger.i('Fetching stream');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response =
            await client.getStream(GetStreamRequest(streamID: streamId));
        _logger.d('Stream: ${response.stream}');
        return response.stream;
      },
    );
  }

  /// fetches the live now streams
  ///
  /// This method sends a `getNowLive` gRPC call to fetch the live now streams.
  ///
  /// Returns a [List<Stream>] instance that represents the live now streams.
  Future<List<Stream>> fetchLiveNowStreams() async {
    _logger.i('Fetching live now stream');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client.getNowLive(GetNowLiveRequest());
        _logger.d('Live now stream: ${response.stream}');
        return response.stream;
      },
    );
  }

  /// Fetches the thumbnail stream.
  ///
  /// This method sends a `getThumbsLive` gRPC call to fetch the thumbnail stream.
  ///
  /// Takes [streamId] as a parameter.
  /// Returns a [String] instance that represents the thumbnail stream.
  Future<String> fetchThumbnailStreams(int streamId) async {
    _logger.i('Fetching thumbnail stream');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response = await client
            .getThumbsLive(GetThumbsLiveRequest(streamID: streamId));
        _logger.d('Thumbnail stream: ${response.path}');
        return response.path;
      },
    );
  }

  /// Fetches the thumbnail VOD.
  ///
  /// This method sends a `getThumbsVOD` gRPC call to fetch the thumbnail VOD.
  ///
  /// Takes [streamId] as a parameter.
  /// Returns a [String] instance that represents the thumbnail VOD.
  Future<String> fetchThumbnailVOD(int streamId) async {
    _logger.i('Fetching thumbnail VOD');
    return _grpcHandler.callGrpcMethod(
      (client) async {
        final response =
            await client.getThumbsVOD(GetThumbsVODRequest(streamID: streamId));
        _logger.d('Thumbnail VOD: ${response.path}');
        return response.path;
      },
    );
  }

  /// Fetches the progress of a stream.
  ///
  /// This method sends a `getProgress` gRPC call to fetch the progress of a stream.
  ///
  /// Takes [streamId] as a parameter.
  /// Returns a [Progress] instance that represents the progress of the stream.
  Future<Progress> fetchProgress(int streamId) async {
    _logger.i('Fetching progress');
    try {
      return _grpcHandler.callGrpcMethod(
        (client) async {
          final response =
              await client.getProgress(GetProgressRequest(streamID: streamId));

          _logger.i('Progress: ${response.progress}');
          return response.progress;
        },
      );
    } catch (e) {
      _logger.e('Progress not found, returning default value');
      return Progress(progress: 0.0);
    }
  }

  /// Updates the progress of a stream.
  ///
  /// This method sends a `putProgress` gRPC call to update the progress of a stream.
  ///
  /// Takes [streamId] and [progress] as parameters.
  Future<void> putProgress(int streamId, Progress progress) async {
    _logger.i('Updating progress');
    await _grpcHandler.callGrpcMethod(
      (client) async {
        await client.putProgress(
          PutProgressRequest(
            streamID: streamId,
            progress: progress.progress,
          ),
        );
        _logger.d('Progress updated');
      },
    );
  }

  /// Marks a stream as watched.
  ///
  /// This method sends a `markAsWatched` gRPC call to mark a stream as watched.
  ///
  /// Takes [streamId] as a parameter.
  Future<void> markAsWatched(int streamId) async {
    _logger.i('Marking stream as watched');
    await _grpcHandler.callGrpcMethod(
      (client) async {
        await client.markAsWatched(MarkAsWatchedRequest(streamID: streamId));
        _logger.d('Stream marked as watched');
      },
    );
  }
}
