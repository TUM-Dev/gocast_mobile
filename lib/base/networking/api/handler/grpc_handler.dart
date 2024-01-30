import 'dart:io';

import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:grpc/grpc.dart';
import 'package:logger/logger.dart';

/// Handles gRPC communication for the application.
class GrpcHandler {
  static final Logger _logger = Logger();

  final String host;
  final int port;
  late ClientChannel _channel;

  /// Creates a new instance of the `GrpcHandler` class.
  ///
  /// The [host] and [port] are required.
  GrpcHandler(this.host, this.port) {
    _logger.i('Creating GrpcHandler: Connecting to gRPC server at $host:$port');
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.secure()),
    );
  }

  /// Shuts down the gRPC client channel.
  Future<void> shutdown() async {
    _logger.i('Shutting down GrpcHandler');
    await _channel.shutdown();
  }

  /// Calls a gRPC method.
  ///
  /// This method takes a [grpcMethod] function that makes the actual gRPC call.
  /// It handles loading the JWT token, setting up the call options, and error handling.
  ///
  /// Throws an [AppError] if a network error occurs or if the gRPC call fails.
  Future<T> callGrpcMethod<T>(
    Future<T> Function(APIClient client) grpcMethod,
  ) async {
    _logger.d('callGrpcMethod: Initiating gRPC call');
    try {
      String token = '';
      try {
        token = await TokenHandler.loadToken('jwt');
      }catch(e) {
        token = '';
      }
      CallOptions callOptions;
      if(token.isNotEmpty) {
        final metadata = <String, String>{
          'grpcgateway-cookie': 'jwt=$token',
        };
         callOptions = CallOptions(metadata: metadata);
      }else {
         callOptions = CallOptions();
      }
      return await grpcMethod(APIClient(_channel, options: callOptions));
    } on SocketException catch (socketException) {
      _logger
          .e('SocketException in callGrpcMethod: ${socketException.message}');
      throw AppError.networkError(socketException.message);
    } catch (e) {
      _logger.e('Error in callGrpcMethod: $e');
      if (e is GrpcError) {
        _logger.e('gRPC error: ${e.code}, ${e.message}');
        throw mapGrpcErrorToAppError(e);
      } else {
        _logger.e('Unknown error: $e');
        throw AppError.networkError(e);
      }
    }
  }

  /// Maps gRPC status codes to [AppError].
  ///
  /// Takes a [GrpcError] and returns an [AppError] that corresponds to the gRPC status code.
  static AppError mapGrpcErrorToAppError(GrpcError error) {
    _logger.d('Mapping gRPC error to AppError: ${error.code}');
    switch (error.code) {
      case StatusCode.invalidArgument:
        return AppError.argumentError(error.message ?? '');
      case StatusCode.unauthenticated:
        return AppError.authenticationError();
      case StatusCode.permissionDenied:
        return AppError.forbidden();
      case StatusCode.notFound:
        return AppError.notFound();
      case StatusCode.alreadyExists:
        return AppError.conflictError();
      case StatusCode.internal:
        return AppError.internalServerError();
      case StatusCode.unimplemented:
        return AppError.internalServerError();
      case StatusCode.unavailable:
        return AppError.networkError();
      case StatusCode.dataLoss:
        return AppError.internalServerError();
      default:
        return AppError.unknownError(error.message ?? '');
    }
  }
}
