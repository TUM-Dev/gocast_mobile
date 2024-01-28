import 'package:flutter/material.dart';

/// Represents an application error.
///
/// This class is used to represent various types of errors that can occur
/// in the application. Each factory constructor represents a different type
/// of error.
class AppError implements Exception {
  /// The error message.
  final String message;

  /// The original error that caused this error, if any.
  final dynamic originalError;

  /// Creates a new application error with the given message and original error.
  AppError(this.message, [this.originalError]) {
    // Print error to console for debugging
    debugPrint(toString());
  }

  @override
  String toString() {
    return 'AppError: $message\nOriginal error: $originalError';
  }

  /// Represents a network error.
  factory AppError.networkError([dynamic error]) =>
      AppError('📡 Unable to connect to the network', error);

  // Factory constructor for token errors
  factory AppError.tokenSaveError([dynamic error]) =>
      AppError('🔑 Token error occurred', error);

  /// Represents an already_exists error when a resource already exists
  factory AppError.conflictError([dynamic error]) =>
      AppError('Resource already exists');

  /// Represents a JSON parsing error.
  factory AppError.jsonParsingError([dynamic error]) =>
      AppError('🔍 Unable to parse the data', error);

  /// Represents a JSON encoding error.
  factory AppError.jsonEncodingError([dynamic error]) =>
      AppError('🔐 Unable to encode the data', error);

  /// Represents a video processing error.
  factory AppError.videoProcessingError() =>
      AppError('🎥 Unable to process the video');

  /// Represents an argument error (HTTP 400).
  factory AppError.argumentError(String message) =>
      AppError('❌ Invalid argument: $message');

  /// Represents an authentication error (HTTP 401).
  factory AppError.authenticationError() =>
      AppError('🔒 Authentication failed');

  /// Represents a validation error (HTTP 422).
  factory AppError.validationError(String message) =>
      AppError('⚠️ Validation failed: $message');

  /// Represents an internal server error (HTTP 500).
  factory AppError.internalServerError() =>
      AppError('💥 An unexpected error occurred');

  /// Represents a forbidden error (HTTP 403).
  factory AppError.forbidden() => AppError('🚫 Access denied');

  /// Represents a not found error (HTTP 404).
  factory AppError.notFound() => AppError('🔍 Resource not found');

  /// Represents an unknown error.
  factory AppError.unknownError(String? message) =>
      AppError('❓An unknown error occurred {message: $message}');

  factory AppError.userError() => AppError('🥱Username or password are incorrect');
}
