import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:logger/logger.dart';

class ApiHandler {
  static final Logger _logger = Logger();

  /// Handles an HTTP response.
  ///
  /// This method checks the status code of the HTTP response and throws an [AppError] if necessary.
  /// It uses the `handleHttpStatus` method to check the status code and throw the appropriate error.
  ///
  /// The `apiMessage` from the response is passed to the `handleHttpStatus` method and used for the error message
  /// of the [AppError.argumentError] thrown for a 400 status code.
  static void handleHttpResponse(Response response) {
    _logger
        .i('Received HTTP response with status code: ${response.statusCode}');

    if (response.data != null && response.data != '') {
      try {
        // Attempt to decode the response body
        var responseBody = jsonDecode(response.data);
        String? apiMessage = responseBody['message'];

        // Log the extracted message
        if (apiMessage != null) {
          _logger.i('API message: $apiMessage');
        }

        handleHttpStatus(response.statusCode, apiMessage);
      } catch (e) {
        // Log any JSON decoding errors
        _logger.e('Error decoding response data: $e');
      }
    } else {
      _logger.w('Response data is null or empty.');
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
    // Log the received status code and API message
    _logger
        .d('Handling HTTP status code: $statusCode, API message: $apiMessage');

    if (statusCode == null) {
      _logger.e('Status code is null');
      throw AppError.unknownError("Status code is null");
    }

    if (statusCode >= 100 && statusCode < 400) {
      // Log successful response
      _logger.i('Successful HTTP response with status code: $statusCode');
      return;
    }
    // Handle error status codes
    switch (statusCode) {
      case 400:
        _logger.w('HTTP 400 Bad Request: $apiMessage');
        throw AppError.argumentError(apiMessage ?? "Bad Request");
      case 401:
        _logger.w('HTTP 401 Unauthorized');
        throw AppError.authenticationError();
      case 403:
        _logger.w('HTTP 403 Forbidden');
        throw AppError.forbidden();
      case 404:
        _logger.w('HTTP 404 Not Found');
        throw AppError.notFound();
      case 500:
        _logger.e('HTTP 500 Internal Server Error');
        throw AppError.internalServerError();
      default:
        _logger.e('Unknown error with status code: $statusCode');
        throw AppError.unknownError("Status code: $statusCode");
    }
  }
}
