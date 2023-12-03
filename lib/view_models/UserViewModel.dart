import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/handler/auth_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/user_handler.dart';
import 'package:gocast_mobile/main.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends StateNotifier<UserState> {
  final Logger _logger = Logger();

  //BehaviorSubject<bool> isLoading = BehaviorSubject.seeded(false);

  BehaviorSubject<UserState> current =
      BehaviorSubject.seeded(UserState.defaultConstructor());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GrpcHandler _grpcHandler;

  UserViewModel(this._grpcHandler) : super(UserState.defaultConstructor());

  /// Handles basic authentication.
  /// This method call the basicAuth method
  /// If the authentication is successful, it navigates to the courses screen.
  /// If the authentication fails, it shows an error message.
  Future<void> handleBasicLogin(BuildContext context) async {
    await _basicAuth(usernameController.text, passwordController.text).then(
      (value) => {
        if (current.value.user != null)
          {Navigator.pushNamed(context, '/courses')}
        else
          {
            throw AppError.networkError('Authentication failed'),
          },
      },
    );
  }

  /// Handles SSO authentication.
  /// This method call the ssoAuth method
  Future<void> _basicAuth(String email, String password) async {
    current.value.setIsLoading(true);
    try {
      _logger.i('Logging in user with email: $email');
      await AuthHandler.basicAuth(email, password);
      await _fetchUser();
      _logger.i('Logged in user with email: $email');
      _logger.i('User: ${current.value.user}');
    } catch (error) {
      _logger.e(error);
      current.value.setIsLoading(false);
      current.addError(error);
    } finally {
      current.value.setIsLoading(false); // Stop loading
    }
  }

  /// Handles SSO authentication.
  /// This method call the ssoAuth method
  Future<void> ssoAuth(BuildContext context, WidgetRef ref) async {
    current.value.setIsLoading(true); // Start loading
    try {
      _logger.i('Logging in user ${current.value.user} with SSO');
      await AuthHandler.ssoAuth(context, ref);
      await _fetchUser();
      _logger.i('Logged in user ${current.value.user} with SSO');
    } catch (error) {
      current.value.setIsLoading(false);
      current.addError(error);
    } finally {
      current.value.setIsLoading(false); // Stop loading
    }
  }

  Future<void> _fetchUser() async {
    current.value.setIsLoading(true); // Start loading
    try {
      _logger.i('Fetching user');
      var user = await UserHandler(_grpcHandler).fetchUser();
      current.value.setUser(user);
    } catch (error) {
      current.addError(error);
    }
  }

  Future<void> logout() async {
    current.value.removeUser();
    current.value = UserState.defaultConstructor();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    _logger.i('Logged out user and cleared tokens.');
  }

  void clearError() {
    if (current.hasError) {
      current = BehaviorSubject.seeded(UserState.defaultConstructor());
    }
  }
}

final userViewModelProvider = StateNotifierProvider<UserViewModel, UserState>(
  (ref) => UserViewModel(ref.watch(grpcHandlerProvider)),
);
