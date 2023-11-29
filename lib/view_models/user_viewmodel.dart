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
  BehaviorSubject<UserState> current =
      BehaviorSubject.seeded(UserState.defaultConstructor());
  final GrpcHandler _grpcHandler;

  UserViewModel(this._grpcHandler);

  Future<void> basicAuth(String email, String password) async {
    try {
      await AuthHandler.basicAuth(email, password);
      await _fetchUser();
    } catch (error) {
      _logger.e(error);
      current.addError(error);
    }
  }

  Future<void> ssoAuth(BuildContext context) async {
    try {
      await AuthHandler.ssoAuth(context);
      await _fetchUser();
    } catch (error) {
      current.addError(error);
    }
  }

  Future<void> _fetchUser() async {
    try {
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
}
