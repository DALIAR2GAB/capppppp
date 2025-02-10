// Provider: Managing coach state
import 'package:flutter/material.dart';

import '../models/coach.dart';
import '../models/coachprofile.dart';
import '../serviecs/coachprofile.dart';

class CoachProvider with ChangeNotifier {
  CoachProfile? _coachProfile;
  bool _isLoading = false;
  String _errorMessage = '';

  CoachProfile? get coachProfile => _coachProfile;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadCoachProfile(int coachId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final profile = await CoachService.fetchCoachProfile(coachId);
    if (profile != null) {
      _coachProfile = profile;
    } else {
      _errorMessage = 'Failed to load coach profile';
    }

    _isLoading = false;
    notifyListeners();
  }
}