// ignore_for_file: constant_identifier_names

// NOTE: 10.0.2.2 is the android emulator's alias for the loopback address on
//       the host machine. On iOS, use either localhost or the actual IP address
//       of the host machine.

// API ROOT URL
const _ROOT_URL = 'http://10.0.2.2:8081/api';
const _GRPC_HOST = '10.0.2.2';
const _GRPC_PORT = 12544;

// AUTHENTICATION
const _BASIC_AUTH_URL = 'http://10.0.2.2:8081/login';
const _SSO_AUTH_URL = 'https://live.rbg.tum.de/saml/out';
const _SSO_REDIRECT_URL = 'https://live.rbg.tum.de';

// COURSES
const _COURSES_PATH = '/courses';
const _COURSES_LIVE_PATH = '/courses/live';
const _COURSES_USER_PATH = '/courses/user';
const _COURSES_USER_PINNED_PATH = '/courses/user/pinned';
const _COURSES_PUBLIC_PATH = '/courses/public';

// SEMESTERS
const _SEMESTERS_PATH = '/semesters';

// USER AND SERVER NOTIFICATIONS
const _NOTIFICATIONS_USER_PATH = '/notifications';
const _NOTIFICATIONS_SERVER_PATH = '/notifications/server';

class Routes {
  // HTTP routes
  static const basicLogin = _BASIC_AUTH_URL;
  static const ssoLogin = _SSO_AUTH_URL;
  static const ssoRedirect = _SSO_REDIRECT_URL;
  static const courses = _ROOT_URL + _COURSES_PATH;
  static const coursesLive = _ROOT_URL + _COURSES_LIVE_PATH;
  static const coursesUser = _ROOT_URL + _COURSES_USER_PATH;
  static const coursesUserPinned = _ROOT_URL + _COURSES_USER_PINNED_PATH;
  static const coursesPublic = _ROOT_URL + _COURSES_PUBLIC_PATH;
  static const semesters = _ROOT_URL + _SEMESTERS_PATH;
  static const notificationsUser = _ROOT_URL + _NOTIFICATIONS_USER_PATH;
  static const notificationsServer = _ROOT_URL + _NOTIFICATIONS_SERVER_PATH;

  // gRPC routes
  static const grpcHost = _GRPC_HOST;
  static const grpcPort = _GRPC_PORT;
}
