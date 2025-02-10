import 'package:dio/dio.dart';


import '../models/signup.dart';

class SignUpService {
  final Dio _dio = Dio();
  final String apiUrl = "http://192.168.137.194:5000/api/SignUp";

  Future<Map<String, dynamic>> signUp(SignUpModel model) async {
    try {
      final response = await _dio.post(
        apiUrl,
        data: model.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "message": "تم التسجيل بنجاح"};
      } else {
        return {"success": false, "message": response.data};
      }
    } catch (e) {
      return {"success": false, "message": "حدث خطأ: $e"};
    }
  }
}