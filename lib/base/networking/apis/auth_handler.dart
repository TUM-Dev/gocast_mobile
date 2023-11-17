import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:gocast_mobile/base/helpers/model_generator.dart';
import 'package:gocast_mobile/model/user_model.dart';
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

    await dio.post(
      url,
      data: formData,
    );

    // For debug purposes only:
    List<Cookie> cookies = await cookieJar.loadForRequest(Uri.parse(url));
    print(
      'UserCookie: ${cookies.isNotEmpty ? cookies[0].value : 'No cookie set'}',
    );
  }

  // TODO@carlobortolan: Finish implementing TUM SSO
  static Future<void> ssoAuth(BuildContext context) async {
    print('ssoAuth started');
    // Step 1: Redirect the user to the Shibboleth login page
    const loginUrl = 'https://live.rbg.tum.de/saml/out';
    print('Login URL: $loginUrl');

    // Step 2: Open the login page in a web view
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
            // Step 3: Redirect back to app and save cookie
            if (url != null &&
                url.toString().startsWith(
                      'https://live.rbg.tum.de',
                    )) {
              print('Redirect URL detected: $url');

              // Extract the SAMLResponse parameter from the URL
              final queryParams = Uri.splitQueryString(url.query);
              final samlRequest = queryParams['SAMLRequest'];
              final relayState = queryParams['RelayState'];
              print('SAMLRequest: $samlRequest');
              print('RelayState: $relayState');

              // Send the SAMLResponse to the server to validate it and create a session
              const ssoCallbackUrl = 'https://live.rbg.tum.de/shib';
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
                'SAMLResponse': samlRequest,
              });

              print('Sending SAMLResponse to server');
              await dio.post(
                ssoCallbackUrl,
                data: formData,
              );
              print('SAMLResponse sent to server');

              // Close the web view and go back to the app
              print('Closing web view and returning to app');
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
    print('ssoAuth finished');
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
