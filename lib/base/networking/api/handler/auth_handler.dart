import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:gocast_mobile/base/networking/api/handler/api_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/views/utils/globals.dart';
import 'package:gocast_mobile/views/utils/routes.dart';
import 'package:logger/logger.dart';

/// Handles authentication for the application.
class AuthHandler {
  static final Logger _logger = Logger();

  /// Performs basic authentication.
  ///
  /// This method sends a POST request to the basic login URL with the given
  /// username and password. If the request is successful, it saves the JWT token.
  ///
  /// Throws an [AppError] if a network error occurs or if no JWT-cookie is set.
  static Future<void> basicAuth(
    String username,
    String password,
  ) async {
    var url = Routes.basicLogin;
    _logger.i('Starting basic authentication for user: $username');
    final cookieJar = CookieJar();
    final dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    dio.interceptors.add(CookieManager(cookieJar));

    final formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    try {
      final response = await dio.post(url, data: formData);
      ApiHandler.handleHttpResponse(response);
      _logger.i('Authentication successful for user: $username');
    } catch (e) {
      _logger.e('Authentication failed for user: $username, Error: $e');
      // Throw the error so it can be caught and handled by the caller of basicAuth
      throw AppError.networkError(e.toString());
    }

    // Save jwt token
    try {
      List<Cookie> cookies = await cookieJar.loadForRequest(Uri.parse(url));
      await TokenHandler.saveToken('jwt', cookies);
      _logger.i('JWT token saved successfully for user: $username');
    } catch (e) {
      _logger.e('Error saving JWT token for user: $username, Error: $e');
      throw AppError.tokenSaveError(e);
    }
  }

  /// Performs SSO authentication.
  ///
  /// This method opens the TUM -SSO login page in a web view. After the user
  /// logs in, it saves the JWT token and redirects back to the app.
  ///
  /// Throws an [AppError] if a network error occurs or if no JWT-cookie is set.
  static Future<void> ssoAuth(BuildContext context) async {
    _logger.i('Starting SSO authentication');
    // Open the login page in a web view
    await Navigator.push(
      context,
      MaterialPageRoute(
        // Redirect the user to the Shibboleth login page
        builder: (context) => webview.InAppWebView(
          initialUrlRequest:
              webview.URLRequest(url: Uri.parse(Routes.ssoLogin)),
          onLoadStop:
              (webview.InAppWebViewController controller, Uri? url) async {
            try {
              if (url != null) {
                _logger.d('Web view loaded URL: $url');
                // Token retrieval and saving logic
                final cookieManager = webview.CookieManager.instance();
                List<webview.Cookie> cookies =
                    await cookieManager.getCookies(url: url);
                // Log the cookie retrieval
                _logger.d('Retrieved cookies from URL: $url');

                await TokenHandler.saveToken(
                  'jwt',
                  cookies.map((c) => Cookie(c.name, c.value)).toList(),
                );
                _logger.i('JWT token saved successfully');

                // Check if the URL is the redirect URL
                if (url.toString().startsWith(Routes.ssoRedirect)) {
                  // Close the web view and go back to the app
                  navigatorKey.currentState?.pop();
                  _logger.i('SSO authentication completed, redirected to app');
                }
              } else {
                _logger.w('URL is null in web view onLoadStop');
              }
            } catch (e) {
              _logger.e('Error during SSO authentication: $e');
              // Throw the error so it can be caught and handled by the caller of ssoAuth
              throw AppError.networkError(e);
            }
          },
        ),
      ),
    );
  }
}
