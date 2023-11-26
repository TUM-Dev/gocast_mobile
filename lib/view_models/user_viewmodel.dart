// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/auth_handler.dart';
import 'package:gocast_mobile/base/networking/api/grpc_handler.dart';
import 'package:gocast_mobile/base/networking/api/user_handler.dart';
import 'package:gocast_mobile/models/user/user_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class UserViewModel {
  BehaviorSubject<UserState> current =
      BehaviorSubject.seeded(UserState.defaultConstructor());

  final GrpcHandler _grpcHandler;

  UserViewModel(this._grpcHandler);
  Future<void> basicAuth(String email, String password) async {
    await AuthHandler.basicAuth(email, password).then(
      (value) => _fetchUser(),
      onError: (error) => current.addError(error),
    );
  }

  Future<void> ssoAuth(BuildContext context) async {
    await AuthHandler.ssoAuth(context).then(
      (value) => _fetchUser(),
      onError: (error) => current.addError(error),
    );
  }

  Future<void> _fetchUser() async {
    await UserHandler(_grpcHandler).fetchUser().then(
          (value) => current.value.setUser(value),
          onError: (error) => current.addError(error),
        );
  }

  Future<void> logout() async {
    current.value.removeUser();
    current.value = UserState.defaultConstructor();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    debugPrint('Logged out user and cleared tokens.');
  }
}