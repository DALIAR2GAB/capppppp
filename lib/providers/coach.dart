import 'package:flutter/material.dart';
import '../models/coach.dart';
import '../serviecs/coach.dart';


class CoachProvider with ChangeNotifier {
  List<CoachProfile> _coaches = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<CoachProfile> get coaches => _coaches;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final CoachService _coachService = CoachService();

  Future<void> fetchCoaches() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _coaches = await _coachService.fetchCoaches();
    } catch (e) {
      _errorMessage = e.toString(); // تخزين رسالة الخطأ
      print("Error in Provider: $e"); // طباعة الخطأ
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}