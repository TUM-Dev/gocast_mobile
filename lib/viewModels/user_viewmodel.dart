import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/apis/auth_handler.dart';
import 'package:gocast_mobile/model/user_model.dart';

class UserViewModel with ChangeNotifier {
  UserViewModel(this.current);
  final UserState current;

  // Sign in user and store cookie
  Future<void> basicAuth(String email, String password) async {
    await AuthHandler.basicAuth(email, password)
        .then((value) => AuthHandler.fetchUser().then(current.setUser));
    notifyListeners();
  }

  Future<void> ssoAuth(BuildContext context) async {
    await AuthHandler.ssoAuth(context)
        .then((value) => AuthHandler.fetchUser().then(current.setUser));
    notifyListeners();
  }

  void logout() {
    current.removeUser();
    notifyListeners();
  }
}
