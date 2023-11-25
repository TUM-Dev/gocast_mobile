import 'package:gocast_mobile/models/error_model.dart';
import 'package:grpc/grpc.dart';

class GrpcHandler {
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
