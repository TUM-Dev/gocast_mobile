import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/handler/auth_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/handler/user_handler.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel {
  final Logger _logger = Logger();

  BehaviorSubject<bool> isLoading = BehaviorSubject.seeded(false);

  BehaviorSubject<UserState> current =
      BehaviorSubject.seeded(UserState.defaultConstructor());

  final GrpcHandler _grpcHandler;

  UserViewModel(this._grpcHandler);

  Future<void> basicAuth(String email, String password) async {
    isLoading.add(true); // Start loading
    try {
      _logger.i('Logging in user with email: $email');
      await AuthHandler.basicAuth(email, password);
      await _fetchUser();
      _logger.i('Logged in user with email: $email');
      _logger.i('User: ${current.value.user}');
    } catch (error) {
      _logger.e(error);
      current.addError(error);
    } finally {
      isLoading.add(false); // Stop loading
    }
  }

  Future<void> ssoAuth(BuildContext context) async {
    isLoading.add(true); // Start loading
    try {
      _logger.i('Logging in user ${current.value.user} with SSO');
      await AuthHandler.ssoAuth(context);
      await _fetchUser();
      _logger.i('Logged in user ${current.value.user} with SSO');
    } catch (error) {
      current.addError(error);
    } finally {
      isLoading.add(false); // Stop loading
    }
  }

  Future<void> _fetchUser() async {
    isLoading.add(true); // Start loading
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

  void dispose() {
    current.close();
  }

  void clearError() {
    if (current.hasError) {
      current = BehaviorSubject.seeded(UserState.defaultConstructor());
    }
  }
}
