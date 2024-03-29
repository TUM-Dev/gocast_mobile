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
  static String cachedToken = '';

  /// Stores a token.
  ///
  /// This method saves a token to shared preferences. The token is identified
  /// by the given key and is extracted from the list of cookies.
  ///
  /// Throws an [AppError] with an authentication error message if no JWT token
  /// is found in the list of cookies.
  static Future<void> saveTokenFromCookies(
    String key,
    List<Cookie> cookies,
  ) async {
    for (var cookie in cookies) {
      if (cookie.name == key) {
        await _storage.write(key: key, value: cookie.value);
        _logger.i('Token saved to secure storage: ${cookie.value}');
        return;
      }
    }
    _logger.w("Token not found in cookies.");
    throw AppError.authenticationError();
  }

  /// Stores a token.
  ///
  /// This method saves a JWT token to shared preferences. The token is identified
  /// by the given key and value.
  ///
  /// Throws an [AppError] with an authentication error message if no JWT token
  /// is found in the list of cookies.
  static Future<void> saveToken(String key, String value) async {
    await _storage.write(key: key, value: value);
    _logger.i('Token saved to secure storage: $value');
    return;
  }

  /// Retrieves a token.
  ///
  /// This method loads a token from shared preferences. The token is identified
  /// by the given key.
  ///
  /// Throws an [AppError] with an authentication error message if no token is
  /// found in shared preferences.
  static Future<String> loadToken(String key) async {
    try {
      final token = await _storage.read(key: key);
      if (token == null) {
        _logger.w('Token not found for key: $key');
        return '';
      }
      _logger.i('Token successfully loaded for key: $key');
      return token;
    } catch (e) {
      _logger.e('Error loading token: $e');
      throw AppError.authenticationError();
    }
  }

  /// Retrieves a token.
  ///
  /// This method loads a token from shared preferences. The token is identified
  /// by the given key.
  ///
  /// Throws an [AppError] with an authentication error message if no token is
  /// found in shared preferences.
  static Future<String> loadTokenNoException(String key) async {
    try {
      final token = await _storage.read(key: key);
      if (token == null) {
        _logger.w('Token not found for key: $key');
        return "";
      }
      _logger.i('Token successfully loaded for key: $key');
      return token;
    } catch (e) {
      _logger.e('Error loading token: $e');
      return "";
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
      await _invalidateToken();
      _logger.i('Token successfully deleted for key: $key');
    } catch (e) {
      _logger.e('Error deleting token: $e');
      throw AppError.notFound();
    }
  }

  static Future<String> getToken() async {
    if (cachedToken.isNotEmpty) {
      _logger.d('Using cached token');
      return cachedToken;
    }
    _logger.d('Loading token from storage');
    cachedToken = await loadToken('jwt');
    return cachedToken;
  }

  static Future<void> _invalidateToken() async {
    cachedToken = '';
  }
}
