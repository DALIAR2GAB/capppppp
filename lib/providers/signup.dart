import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/signup.dart';
import '../serviecs/signup.dart';

class SignUpProvider with ChangeNotifier {
  final SignUpService _service = SignUpService();
  bool isLoading = false;
  String errorMessage = "";

  Future<bool> register(SignUpModel model, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final result = await _service.signUp(model);

    isLoading = false;
    notifyListeners();

    if (result["success"]) {
      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful!"), backgroundColor: Colors.green),
      );
      return true;
    } else {
      // Error message
      errorMessage = result["message"];
      notifyListeners();
      return false;
    }
  }
}