import 'package:dio/dio.dart';
import '../models/doctor.dart';

class DoctorService {
  final Dio dio = Dio();
  Future<List<DoctorProfile>> getAllProfiles() async {
    try {
      final response = await dio.get('http://192.168.137.194:5000/api/Doctor/getAllProfiles');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((profile) => DoctorProfile.fromJson(profile)).toList();
      } else {
        throw Exception('Failed to load profiles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
