import 'package:flutter/material.dart';

import '../models/login.dart';
import '../serviecs/login.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _loginError;
  final AuthService _authService = AuthService(); // ربط الخدمة

  bool get isAuthenticated => _isAuthenticated;
  String? get loginError => _loginError;

  Future<void> login(User user) async {
    try {
      bool success = await _authService.login(user); // استدعاء خدمة تسجيل الدخول
      if (success) {
        _isAuthenticated = true;
        _loginError = null;
      } else {
        _isAuthenticated = false;
        _loginError = 'Invalid username or password';
      }
    } catch (error) {
      _isAuthenticated = false;
      _loginError = error.toString();
    }
    notifyListeners();
  }
}