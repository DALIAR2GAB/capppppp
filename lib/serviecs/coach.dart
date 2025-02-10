import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coach.dart';

class CoachService {
  final String apiUrl = "http://192.168.137.194:5000/api/Coach/getall";

  Future<List<CoachProfile>> fetchCoaches() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      print("Status Code: ${response.statusCode}"); // طباعة حالة الاستجابة
      print("Response Body: ${response.body}"); // طباعة الجسم

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<CoachProfile> coaches = body.map((dynamic item) => CoachProfile.fromJson(item)).toList();
        return coaches;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e"); // طباعة أي خطأ يحدث
      throw Exception('Failed to load data: $e');
    }
  }
}