import 'package:flutter/material.dart';

import '../models/notifaction.dart';
import '../serviecs/notifaction.dart';


class NotificationProvider with ChangeNotifier {
  NotificationModel? _notification;
  final NotificationService _service = NotificationService();

  NotificationModel? get notification => _notification;

  Future<void> fetchNotification() async {
    _notification = await _service.fetchNotification();
    notifyListeners();
  }
}