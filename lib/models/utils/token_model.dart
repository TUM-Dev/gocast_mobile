import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Handles the storage and retrieval of JWT tokens.
///
/// This class provides methods for saving and loading JWT tokens. The tokens
/// are stored in shared preferences and are identified by a key.
class Token {
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(key, cookie.value);
        debugPrint("Saved token: ${cookie.value}");
        return;
      }
    }

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? (throw AppError.authenticationError());
  }
}
