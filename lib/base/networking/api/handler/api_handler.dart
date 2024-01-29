import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:logger/logger.dart';

/// Handles HTTP communication for the application.
class ApiHandler {
  static final Logger _logger = Logger();

  /// Handles an HTTP error response.
  ///
  /// This method takes a [response] and handles the error based on the status code.
  ///
  /// Throws an [AppError] if the status code is not in the 2xx range.
  static void handleHttpResponse(Response response) {
    _logger
        .i('Received HTTP response with status code: ${response.statusCode}');
    if (response.data != null && response.data != '') {
      try {
        var responseBody = jsonDecode(response.data);
        String? apiMessage = responseBody['message'];
        if (apiMessage != null) {
          _logger.i('API message: $apiMessage');
        }
        handleHttpStatus(response.statusCode, apiMessage);
      } catch (e) {
        _logger.e('Error decoding response data: $e');
      }
    } else {
      _logger.w('Response data is null or empty.');
      handleHttpStatus(response.statusCode, null);
    }
  }

  /// Handles an HTTP status code.
  ///
  /// This method takes a [statusCode] and [apiMessage] and throws an [AppError]
  /// based on the status code.
  static void handleHttpStatus(int? statusCode, String? apiMessage) {
    _logger.i('Handling HTTP status code: $statusCode, API message: $apiMessage');
    if (statusCode == null) {
      throw AppError.unknownError("Status code is null");
    }
    if (statusCode < 100 || statusCode >= 400) {
      switch (statusCode) {
        case 400:
          throw AppError.argumentError(apiMessage ?? "Bad Request");
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
}
