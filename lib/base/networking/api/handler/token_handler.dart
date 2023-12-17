import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:logger/logger.dart';

/// Handles the storage and retrieval of JWT tokens.
///
/// This class provides methods for saving and loading JWT tokens. The tokens
/// are stored in shared preferences and are identified by a key.
class TokenHandler {
  static final Logger _logger = Logger();
  static const _storage = FlutterSecureStorage();

  /// Stores a JWT token.
  ///
  /// This method saves a JWT token to shared preferences. The token is identified
  /// by the given key and is extracted from the list of cookies.
  ///
  /// Throws an [AppError] with an authentication error message if no JWT token
  /// is found in the list of cookies.
  static Future<void> saveToken(String key, List<Cookie> cookies) async {
    for (var cookie in cookies) {
      if (cookie.name == key) {
        await _storage.write(key: key, value: cookie.value);
        _logger.i('Token saved to secure storage: ${cookie.value}');
        return;
      }
    }
    _logger.w("Token not found in cookies.");
    // Handle error when no jwt cookie is found
    throw AppError.authenticationError();
  }

  /// Retrieves a JWT token.
  ///
  /// This method loads a JWT token from shared preferences. The token is identified
  /// by the given key.
  ///
  /// Throws an [AppError] with an authentication error message if no JWT token
  /// is found in shared preferences.
  static Future<String> loadToken(String key) async {
    try {
      final token = await _storage.read(key: key);
      if (token == null) {
        _logger.w('Token not found for key: $key');
        throw AppError.authenticationError();
      }

      _logger.i('Token successfully loaded for key: $key');
      return token;
    } catch (e) {
      _logger.e('Error loading token: $e');
      throw AppError.authenticationError();
    }
  }

  /// Deletes a JWT token.
  ///
  /// This method deletes a JWT token from shared preferences. The token is identified
  /// by the given key.
  ///
  /// Throws an [AppError] with an authentication error message if no JWT token
  /// is found in shared preferences.
  static Future<void> deleteToken(String key) async {
    try {
      await _storage.delete(key: key);
      _logger.i('Token successfully deleted for key: $key');
    } catch (e) {
      _logger.e('Error deleting token: $e');
      throw AppError.authenticationError();
    }
  }
}
