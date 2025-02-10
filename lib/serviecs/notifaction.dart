import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notifaction.dart';

class NotificationService {
  final String apiUrl = "http://192.168.137.194:5000/api/Notification/getLatestDoctor";

  Future<NotificationModel> fetchNotification() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return NotificationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load notification');
    }
  }
}