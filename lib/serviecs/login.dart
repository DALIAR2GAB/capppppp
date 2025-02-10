import 'dart:convert';
import 'package:dio/dio.dart';

import '../models/login.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<bool> login(User user) async {
    try {
      final response = await _dio.post(
        'http://192.168.137.194:5000/api/Login/authenticate',
        data: json.encode(user.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw 'Invalid credentials';
      }
    } catch (e) {
      throw 'Login failed: $e';
    }
  }
}