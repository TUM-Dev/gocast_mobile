import 'dart:io';

class AppConfig {
  AppConfig._(); // Private constructor

  // Determine the root URL based on the platform
  // Used for development only. Once the api is deployed, this can be ignored.
  static String get _rootUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8081/api';
    } else if (Platform.isIOS) {
      return 'http://localhost:8081/api';
    }
    throw UnsupportedError('Unsupported platform');
  }

  // AUTHENTICATION
  static String get basicAuthUrl =>
      '${_rootUrl.replaceFirst('/api', '')}/login';
  static String get ssoAuthUrl => 'https://live.rbg.tum.de/saml/out';
  static String get ssoRedirectUrl => 'https://live.rbg.tum.de';

  // gRPC routes
  static String get grpcHost {
    return Platform.isAndroid
        ? '10.0.2.2'
        : 'localhost'; // Or host machine IP for iOS
  }

  static const int grpcPort = 12544;
}

class Routes {
  // HTTP routes
  static String get basicLogin => AppConfig.basicAuthUrl;
  static String get ssoLogin => AppConfig.ssoAuthUrl;
  static String get ssoRedirect => AppConfig.ssoRedirectUrl;

  // gRPC config
  static String get grpcHost => AppConfig.grpcHost;
  static const int grpcPort = AppConfig.grpcPort;
}
