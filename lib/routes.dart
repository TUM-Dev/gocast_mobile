// ignore_for_file: constant_identifier_names

// API ROOT URL
const _ROOT_URL = 'http://10.0.2.2:8081/api';

// AUTHENTICATION
const _BASIC_AUTH_URL = 'http://10.0.2.2:8081/login';

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
  static const basicLogin = _BASIC_AUTH_URL;
  static const courses = _ROOT_URL + _COURSES_PATH;
  static const coursesLive = _ROOT_URL + _COURSES_LIVE_PATH;
  static const coursesUser = _ROOT_URL + _COURSES_USER_PATH;
  static const coursesUserPinned = _ROOT_URL + _COURSES_USER_PINNED_PATH;
  static const coursesPublic = _ROOT_URL + _COURSES_PUBLIC_PATH;
  static const semesters = _ROOT_URL + _SEMESTERS_PATH;
  static const notificationsUser = _ROOT_URL + _NOTIFICATIONS_USER_PATH;
  static const notificationsServer = _ROOT_URL + _NOTIFICATIONS_SERVER_PATH;
}
