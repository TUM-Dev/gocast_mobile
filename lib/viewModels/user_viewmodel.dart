// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/apis/auth_handler.dart';
import 'package:gocast_mobile/model/user/user_model.dart';
import 'package:gocast_mobile/model/user/user_state_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class UserViewModel {
  BehaviorSubject<UserState> current =
      BehaviorSubject.seeded(UserState.defaultConstructor());

  // Sign in user and store cookie
  Future<void> basicAuth(String email, String password) async {
    await AuthHandler.basicAuth(email, password).then(
      (value) => AuthHandler.fetchUser().then(
        (value) => current.value.setUser(value),
        onError: (error) => current.addError(error),
      ),
      onError: (error) => current.addError(error),
    );
  }

  Future<void> ssoAuth(BuildContext context) async {
    await AuthHandler.ssoAuth(context).then(
      (value) => AuthHandler.fetchUser().then(
        (value) => current.value.setUser(value),
        onError: (error) => current.addError(error),
      ),
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
