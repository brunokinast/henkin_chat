import 'package:flutter/material.dart';

enum AuthMode {
  login,
  signup,
}

class AuthData {
  String name;
  String email;
  String password;
  Color color;
  bool isSignUp;

  AuthData({
    this.name = '',
    this.email = '',
    this.password = '',
    this.color = Colors.deepOrange,
    this.isSignUp = false,
  });
}
