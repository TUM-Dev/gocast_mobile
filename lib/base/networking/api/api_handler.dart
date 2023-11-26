import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:gocast_mobile/models/error_model.dart';

class ApiHandler {
  /// Handles an HTTP response.
  ///
  /// This method checks the status code of the HTTP response and throws an [AppError] if necessary.
  /// It uses the `handleHttpStatus` method to check the status code and throw the appropriate error.
  ///
  /// The `apiMessage` from the response is passed to the `handleHttpStatus` method and used for the error message
  /// of the [AppError.argumentError] thrown for a 400 status code.
  static void handleHttpResponse(Response response) {
    // Decode the response body
    if (response.data != null && response.data != '') {
      // Extract the message from the decoded response body
      var responseBody = jsonDecode(response.data);
      String? apiMessage = responseBody['message'];
      handleHttpStatus(response.statusCode, apiMessage);
    } else {
      handleHttpStatus(response.statusCode, null);
    }
  }

  /// Handles the HTTP status code of a response and throws an [AppError] if necessary.
  ///
  /// This method checks the HTTP status code and throws an [AppError] for certain status codes.
  /// If the status code is null or not in the range of 100 to 399, it throws an [AppError].
  /// For status codes 400, 401, 403, 404, and 500, it throws specific [AppError]s.
  /// For all other status codes, it throws an [AppError.unknownError].
  ///
  /// The method also accepts an optional `apiMessage` parameter. If provided, this message
  /// is used for the error message of the [AppError.argumentError] thrown for a 400 status code.
  ///
  /// - 1xx-3xx: No error is thrown
  /// - 400: [AppError.argumentError] is thrown with `apiMessage` as the error message
  /// - 401: [AppError.authenticationError] is thrown
  /// - 403: [AppError.forbidden] is thrown
  /// - 404: [AppError.notFound] is thrown
  /// - 500: [AppError.internalServerError] is thrown
  /// - Other: [AppError.unknownError] is thrown
  static void handleHttpStatus(int? statusCode, String? apiMessage) {
    if (statusCode == null) {
      throw AppError.unknownError("Status code is null");
    }

    if (statusCode >= 100 && statusCode < 400) {
      // No error
      return;
    }

    switch (statusCode) {
      case 400:
        throw AppError.argumentError(apiMessage ?? "");
      case 401:
        throw AppError.authenticationError();
      case 403:
        throw AppError.forbidden();
      case 404:
        throw AppError.notFound();
      case 500:
        throw AppError.internalServerError();
      default:
        throw AppError.unknownError("Status code: $statusCode");
    }
  }
}
