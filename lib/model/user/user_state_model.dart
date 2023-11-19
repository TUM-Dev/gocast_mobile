// ignore_for_file: always_put_required_named_parameters_first
import 'package:flutter/material.dart';
import 'package:gocast_mobile/model/user/user_model.dart';

class UserState {
  UserState({
    required this.isLoading,
    this.user,
    // Placeholder for future helpers (e.g. error handling)
    required this.errorMessage,
  });

  // Default constructor
  UserState.defaultConstructor()
      : isLoading = false,
        errorMessage = '',
        user = null;

  bool isLoading;
  User? user;
  String errorMessage;

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
