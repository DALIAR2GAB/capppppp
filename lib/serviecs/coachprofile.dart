import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coach.dart';

class CoachService {
  static Future<CoachProfile?> fetchCoachProfile(int coachId) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.137.194:5000/api/Coach/profiles/$coachId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return CoachProfile.fromJson(data[0]);
        }
      }
    } catch (e) {
      print('Error fetching coach profile: $e');
    }
    return null;
  }
}