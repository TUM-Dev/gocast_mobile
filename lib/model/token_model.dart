import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

// This class will be extended once the API/v2 is implemented
class Token {
  static Future<void> saveToken(List<Cookie> cookies) async {
    for (var cookie in cookies) {
      if (cookie.name == 'jwt') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', cookie.value);

        // DEBUG: Check cookie
        String? jwt = prefs.getString('jwt');
        debugPrint('Current jwt: $jwt');
        return;
      }
    }

    // Handle error when no jwt cookie is found
    throw Exception('No JWT cookie found');
  }
}
