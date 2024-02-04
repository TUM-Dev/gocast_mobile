/// AppConfig - Defines the configuration for the application.
class AppConfig {
  static const String appName = 'GoCast Mobile';
  static const String appVersion = '0.2.0';
  static const String appDescription = 'GoCast Mobile App';

  AppConfig._(); // Private constructor

  static String get _rootUrl => 'https://1279.test.live.mm.rbg.tum.de';

  // Authentication URLs
  static String get basicAuthUrl =>
      '${_rootUrl.replaceFirst('/api', '')}/login';

  static String get ssoAuthUrl => 'https://live.rbg.tum.de/saml/out';

  static String get ssoRedirectUrl => 'https://live.rbg.tum.de';

  // gRPC routes
  static String get grpcHost => 'grpc-1279.test.live.mm.rbg.tum.de';

  static const int grpcPort = 443;
}

/// Routes - Defines HTTP and gRPC routes for the application.
class Routes {
  Routes._(); // Private constructor
  // HTTP routes
  static String get basicLogin => AppConfig.basicAuthUrl;

  static String get ssoLogin => AppConfig.ssoAuthUrl;

  static String get ssoRedirect => AppConfig.ssoRedirectUrl;

  // gRPC config
  static String get grpcHost => AppConfig.grpcHost;
  static const int grpcPort = AppConfig.grpcPort;
}
