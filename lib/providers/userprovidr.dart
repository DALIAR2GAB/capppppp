import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _username = ""; // متغير لحفظ اسم المستخدم

  String get username => _username; // إرجاع الاسم

  void setUsername(String newUsername) {
    _username = newUsername;
    notifyListeners(); // تحديث جميع الواجهات التي تستخدمه
  }
}
