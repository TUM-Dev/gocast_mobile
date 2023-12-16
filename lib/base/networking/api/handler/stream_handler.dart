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
  Future<Stream> fetchStream(Int64? streamId) async {
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
  Future<String> fetchThumbnailStreams(Int64? streamId) async {
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
  Future<String> fetchThumbnailVOD(Int64? streamId) async {
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
}
