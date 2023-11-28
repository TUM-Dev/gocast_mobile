import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:gocast_mobile/base/networking/api/api_handler.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/utils/token_model.dart';
import 'package:gocast_mobile/routes.dart';

/// Handles authentication for the application.
class AuthHandler {
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
    } catch (e) {
      // Throw the error so it can be caught and handled by the caller of basicAuth
      throw AppError.networkError(e);
    }

    // Save jwt token
    List<Cookie> cookies = await cookieJar.loadForRequest(Uri.parse(url));
    await Token.saveToken('jwt', cookies);
  }

  /// Performs SSO authentication.
  ///
  /// This method opens the TUM -SSO login page in a web view. After the user
  /// logs in, it saves the JWT token and redirects back to the app.
  ///
  /// Throws an [AppError] if a network error occurs or if no JWT-cookie is set.
  static Future<void> ssoAuth(BuildContext context) async {
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
              final cookieManager = webview.CookieManager.instance();
              List<webview.Cookie> cookies =
                  await cookieManager.getCookies(url: url!);

              // Save jwt token
              await Token.saveToken(
                'jwt',
                cookies.map((c) => Cookie(c.name, c.value)).toList(),
              );

              // Redirect back to app
              if (url.toString().startsWith(Routes.ssoRedirect)) {
                // Close the web view and go back to the app
                Navigator.pop(context);
              }
            } catch (e) {
              // Throw the error so it can be caught and handled by the caller of ssoAuth
              throw AppError.networkError(e);
            }
          },
        ),
      ),
    );
  }
}
