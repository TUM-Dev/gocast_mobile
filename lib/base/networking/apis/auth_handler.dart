import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:gocast_mobile/base/helpers/model_generator.dart';
import 'package:gocast_mobile/model/user_model.dart';
import 'package:gocast_mobile/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHandler {
  static Future<void> saveToken(List<Cookie> cookies) async {
    for (var cookie in cookies) {
      if (cookie.name == 'jwt') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', cookie.value);

        // DEBUG: Check cookie
        String? jwt = prefs.getString('jwt');
        print('Current jwt: $jwt');
        return;
      }
    }

    // TODO: Handle error when no jwt cookie is found
    print('No JWT cookie found');
  }

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
      // TODO: Handle network errors
      print('Request error: $e');
      return;
    }

    List<Cookie> cookies = await cookieJar.loadForRequest(Uri.parse(url));

    // Save jwt token
    await saveToken(cookies);
  }

  static Future<void> ssoAuth(BuildContext context) async {
    print('ssoAuth started');
    // Redirect the user to the Shibboleth login page
    print('Login URL: $Routes.ssoLogin');

    // Open the login page in a web view
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => webview.InAppWebView(
          initialUrlRequest:
              webview.URLRequest(url: Uri.parse(Routes.ssoLogin)),
          onWebViewCreated: (webview.InAppWebViewController controller) {
            print('Web view created');
          },
          onLoadStart: (webview.InAppWebViewController controller, Uri? url) {
            print('Page load started: $url');
          },
          onLoadStop:
              (webview.InAppWebViewController controller, Uri? url) async {
            print('Page load stopped: $url');

            final cookieManager = webview.CookieManager.instance();
            List<webview.Cookie> cookies =
                await cookieManager.getCookies(url: url!);

            // Save jwt token
            await saveToken(
              cookies.map((c) => Cookie(c.name, c.value)).toList(),
            );

            // Redirect back to app
            if (url.toString().startsWith(Routes.ssoRedirect)) {
              print('Redirect URL detected: $url');

              // Close the web view and go back to the app
              print('Closing web view and returning to app');
              Navigator.pop(context);
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
