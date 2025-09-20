import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  String? _userId;
  String? _role; // store role

  String? get userId => _userId;
  String? get userRole => _role; // expose role

  bool get isLoggedIn => _userId != null;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == "admin@example.com" && password == "admin123") {
      _userId = email;
      _role = 'admin';
      notifyListeners();
      return true;
    } else if (email == "farmer@example.com" && password == "farmer123") {
      _userId = email;
      _role = 'farmer';
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _userId = null;
    _role = null; // clear role
    notifyListeners();
  }

  Future<bool> signup(String email, String password, {String role = 'farmer'}) async {
    await Future.delayed(const Duration(seconds: 1));
    _userId = email;
    _role = role;
    notifyListeners();
    return true;
  }
}
