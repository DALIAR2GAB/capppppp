import 'package:flutter/material.dart';

import '../models/doctor.dart';

import '../serviecs/doctor.dart';

class DoctorProvider with ChangeNotifier {
  List<DoctorProfile> _doctorProfiles = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<DoctorProfile> get doctorProfiles => _doctorProfiles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchDoctorProfiles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _doctorProfiles = await DoctorService().getAllProfiles();
    } catch (e) {
      _errorMessage = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
