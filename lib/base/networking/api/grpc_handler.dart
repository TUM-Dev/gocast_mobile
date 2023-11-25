import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error_model.dart';
import 'package:gocast_mobile/models/token_model.dart';
import 'package:grpc/grpc.dart';

class GrpcHandler {
  final String host;
  final int port;
  late ClientChannel _channel;

  GrpcHandler(this.host, this.port) {
    debugPrint('Connecting to gRPC server at $host:$port');

    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  Future<void> shutdown() async {
    await _channel.shutdown();
  }

  Future<T> callGrpcMethod<T>(
    Future<T> Function(APIClient client) grpcMethod,
  ) async {
    try {
      String token = await Token.loadToken('jwt');
      final metadata = <String, String>{
        'grpcgateway-cookie': 'jwt=$token',
        // Add other headers if needed
      };

      final callOptions = CallOptions(metadata: metadata);

      return await grpcMethod(APIClient(_channel, options: callOptions));
    } on SocketException catch (socketException) {
      throw AppError.networkError(socketException.message);
    } catch (error) {
      debugPrint('Error: $error');
      if (error is GrpcError) {
        throw mapGrpcErrorToAppError(error);
      } else {
        throw AppError.networkError(error);
      }
    }
  }

  // Map gRPC status codes to AppError
  static AppError mapGrpcErrorToAppError(GrpcError error) {
    switch (error.code) {
      case StatusCode.invalidArgument:
        return AppError.argumentError(error.message ?? '');
      case StatusCode.unauthenticated:
        return AppError.authenticationError();
      case StatusCode.permissionDenied:
        return AppError.forbidden();
      case StatusCode.notFound:
        return AppError.notFound();
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
