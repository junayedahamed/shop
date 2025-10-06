import 'package:flutter/material.dart';

class TextFieldEyeTogller extends ChangeNotifier {
  bool _isObscure1 = true, _isObscure2 = true;

  bool get isObscure1 => _isObscure1;
  bool get isObscure2 => _isObscure2;
  void toggle1() {
    _isObscure1 = !_isObscure1;
    notifyListeners();
  }

  void toggle2() {
    _isObscure2 = !_isObscure2;
    notifyListeners();
  }

  String? validatePassword1(String? value1) {
    if (value1 == null || value1.isEmpty) {
      return "Password is required";
    }
    if (value1.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  String? validatePassword2(String? value1, String? value2) {
    if (value1 == null || value1.isEmpty) {
      return "Password is required";
    }
    if (value2 == null || value2.isEmpty) {
      return "Confirm password is required";
    }
    if (value1 != value2) {
      return "Passwords do not match";
    }
    if (value2.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  //email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Full Name is required";
    } else if (value.length < 4) {
      return "Name must be at least 4 characters long";
    }
    return null;
  }
}
