import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:gocast_mobile/base/helpers/model_generator.dart';
import 'package:gocast_mobile/model/token_model.dart';
import 'package:gocast_mobile/model/user/user_model.dart';
import 'package:gocast_mobile/routes.dart';

class AuthHandler {
  static Future<void> basicAuth(
    String username,
    String password,
  ) async {
    const url = Routes.basicLogin;
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
      await dio.post(
        url,
        data: formData,
      );
    } catch (e) {
      // Throw the error so it can be caught and handled in the signIn method
      throw Exception('Request error: $e');
    }

    List<Cookie> cookies = await cookieJar.loadForRequest(Uri.parse(url));

    // Save jwt token
    await Token.saveToken(cookies);
  }

  static Future<void> ssoAuth(BuildContext context) async {
    debugPrint('ssoAuth started');
    // Redirect the user to the Shibboleth login page
    debugPrint('Login URL: $Routes.ssoLogin');

    // Open the login page in a web view
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => webview.InAppWebView(
          initialUrlRequest:
              webview.URLRequest(url: Uri.parse(Routes.ssoLogin)),
          onLoadStop:
              (webview.InAppWebViewController controller, Uri? url) async {
            debugPrint('Page load stopped: $url');

            try {
              final cookieManager = webview.CookieManager.instance();
              List<webview.Cookie> cookies =
                  await cookieManager.getCookies(url: url!);

              // Save jwt token
              await Token.saveToken(
                cookies.map((c) => Cookie(c.name, c.value)).toList(),
              );

              // Redirect back to app
              if (url.toString().startsWith(Routes.ssoRedirect)) {
                debugPrint('Redirect URL detected: $url');

                // Close the web view and go back to the app
                debugPrint('Closing web view and returning to app');
                Navigator.pop(context);
              }
            } catch (e) {
              // Throw the error so it can be caught and handled by the caller of ssoAuth
              throw Exception('Error in ssoAuth: $e');
            }
          },
        ),
      ),
    );
  }

  // Generate user mock for testing the views until API/v2 is implemented
  static Future<User> fetchUser() async {
    // TODO: Add GET:/user endpoint in gocast API to fetch current user information
    return ModelGenerator.generateRandomUser();
  }
}
