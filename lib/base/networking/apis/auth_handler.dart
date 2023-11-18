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

    await dio.post(
      url,
      data: formData,
    );

    // Save jwt token
    List<Cookie> cookies = await cookieJar.loadForRequest(Uri.parse(url));

    if (cookies.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', cookies[0].value);

      // DEBUG: Check cookie - TODO: Remove before merge
      String? jwt = prefs.getString('jwt');
      print('Current jwt: $jwt\nbasicAuth finished.');
    } else {
      // TODO: Handle error
    }
  }

  static Future<void> ssoAuth(BuildContext context) async {
    print('ssoAuth started');
    // Redirect the user to the Shibboleth login page
    const loginUrl = 'https://live.rbg.tum.de/saml/out';
    print('Login URL: $Routes.basicLogin');

    // Open the login page in a web view
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => webview.InAppWebView(
          initialUrlRequest: webview.URLRequest(url: Uri.parse(loginUrl)),
          onWebViewCreated: (webview.InAppWebViewController controller) {
            print('Web view created');
          },
          onLoadStart: (webview.InAppWebViewController controller, Uri? url) {
            print('Page load started: $url');
          },
          onLoadStop:
              (webview.InAppWebViewController controller, Uri? url) async {
            print('Page load stopped: $url');

            // DEBUG: Get the cookies - TODO: Remove before merge
            final cookieManager = webview.CookieManager.instance();
            List<webview.Cookie> cookies =
                await cookieManager.getCookies(url: url!);

            // Save cookie
            if (cookies.isNotEmpty) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('jwt', cookies[0].value);
            }

            // Redirect back to app
            if (url.toString().startsWith('https://live.rbg.tum.de')) {
              print('Redirect URL detected: $url');

              // Close the web view and go back to the app
              print('Closing web view and returning to app');
              Navigator.pop(context);
            }
          },
        ),
      ),
    );

    // DEBUG: Check cookie - TODO: Remove before merge
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    print('Current jwt: $jwt\nssoAuth finished.');
  }

// Just for testing
  static Future<User> fetchUser() async {
    /*
    TODO: Add GET:/user endpoint in gocast API to fetch current user information 
    const url = 'http://localhost:8081/api/user';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Cookie':
            'jwt=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDA0MTc0ODksIlVzZXJJRCI6NCwiU2FtbFN1YmplY3RJRCI6bnVsbH0.gNkwmP2QDieyFb-oAq4zuimlIGozsD5eqlD3ZBs9lLxKE3UpQDVB-ufUmbY_hZq5WE2BVlZ3jLLdQKJKMsvJZNkKRMov_W7ADAxHgVa5IE7WWry9YGLNigVEM_ruagKrp8RyV2MOyA7xQKVudLwfF3RNhcJImVFSkpMTFH6IPr7PvIvilktgNmJDTq4hdieKmzAOQMuNsFxsAIAHXZvAOt9JP0XuIrQMJk6J9Ye201D_V6iObSyMa2AFE7nnTgvOMJeRiuhRrFy9u61XnWc7GfiE9b057aNhTKrTU389Z0vJaHJeIk9c-4x9jLuspMFpX_8g_J-EWfbCWXFHxPRqCQ',
      },
    );
  */
    return ModelGenerator.generateRandomUser();
  }
}
