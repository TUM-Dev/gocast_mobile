import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';

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
