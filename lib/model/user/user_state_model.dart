// ignore_for_file: always_put_required_named_parameters_first
import 'package:flutter/material.dart';
import 'package:gocast_mobile/model/user/user_model.dart';

class UserState {
  bool isLoading;
  User? user;

  UserState({
    required this.isLoading,
    this.user,
  });

  // Default constructor
  UserState.defaultConstructor()
      : isLoading = false,
        user = null;

  void setUser(User newUser) {
    debugPrint("User set to: ${newUser.name}");
    user = newUser;
  }

  void removeUser() {
    user = null;
  }

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void toggleIsLoading() {
    isLoading = !isLoading;
  }
}
