import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/api_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/token_handler.dart';
import 'package:gocast_mobile/main.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/views/utils/globals.dart';
import 'package:gocast_mobile/views/utils/routes.dart';
import 'package:logger/logger.dart';

/// Handles authentication for the application.
class AuthHandler {
  static final Logger _logger = Logger();
  static bool isLoginSuccessful = false;

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

  static Future<void> ssoAuth(BuildContext context, WidgetRef ref) async {
    _logger.i('Starting SSO authentication');
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('TUM Web Login'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
                ref.read(userViewModel).isLoading.add(false);
              },
            ),
          ),
          body: _buildWebView(),
        ),
      ),
    );
    isLoginSuccessful = false; // Reset the flag after WebView is closed
  }

  static Widget _buildWebView() {
    return webview.InAppWebView(
      initialUrlRequest: webview.URLRequest(url: Uri.parse(Routes.ssoLogin)),
      onLoadStop: _onWebViewLoadStop,
    );
  }

  static Future<void> _onWebViewLoadStop(
    webview.InAppWebViewController controller,
    Uri? url,
  ) async {
    try {
      if (url != null && url.toString().startsWith(Routes.ssoRedirect)) {
        _logger.i('Web view loaded URL: $url');
        await _handleCookieRetrieval(url);
        isLoginSuccessful = true; // Set flag to true on successful login
        // Due to the token being signed from TUM Live RBG, the app will not be able to decode it
        // Therefor can´t retrieve the user data from TUM database
        // Once the API for user is implemented and deployed, this will be adapted to redirect to the course_overview_view
        navigatorKey.currentState
            ?.pop(); //Comment this line if you want to continue in the webview
        _logger.i('SSO authentication completed, redirected to app');
      } else if (url != null) {
        _logger.d('Web view loaded URL: $url');
      } else {
        _logger.w('URL is null in web view onLoadStop');
      }
    } catch (e) {
      _logger.e('Error during SSO authentication: $e');
      throw AppError.networkError(e);
    }
  }

  static Future<void> _handleCookieRetrieval(Uri url) async {
    try {
      final cookieManager = webview.CookieManager.instance();
      List<webview.Cookie> cookies = await cookieManager.getCookies(url: url);
      _logger.d('Retrieved cookies from URL: $url');
      webview.Cookie? jwtCookie;
      for (var cookie in cookies) {
        if (cookie.name == 'jwt') {
          jwtCookie = cookie;
          break;
        }
      }
      if (jwtCookie != null) {
        await TokenHandler.saveToken(
          'jwt',
          [Cookie(jwtCookie.name, jwtCookie.value)],
        );
        _logger.i('JWT token saved successfully');
      } else {
        _logger.w('JWT cookie not found in response');
      }
    } catch (e) {
      _logger.e('Error during cookie retrieval: $e');
    }
  }
}
