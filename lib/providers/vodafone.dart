import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/image.dart' as img;

class VodafoneCashProvider with ChangeNotifier {
  File? _image;
  bool _isLoading = false;
  String _confirmationMessage = "";
  bool _isPaymentConfirmed = false;
  final picker = ImagePicker();

  File? get image => _image;
  bool get isLoading => _isLoading;
  String get confirmationMessage => _confirmationMessage;
  bool get isPaymentConfirmed => _isPaymentConfirmed;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);

      // تقليل حجم الصورة
      img.Image? decodedImage = img.decodeImage(await selectedImage.readAsBytes());
      if (decodedImage != null) {
        img.Image smallerImage = img.copyResize(decodedImage, width: 800); // تغيير الحجم
        File compressedImage = File(pickedFile.path)..writeAsBytesSync(img.encodeJpg(smallerImage, quality: 80));

        _image = compressedImage;
        notifyListeners();
      }
    }
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }

  Future<void> uploadImage() async {
    if (_image == null) {
      _confirmationMessage = "Please upload the payment screenshot!";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      var uri = Uri.parse("http://192.168.1.3:5000/api/VodafoneCash/upload");
      var request = http.MultipartRequest("POST", uri);

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          _image!.path,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseData);
        _confirmationMessage = "✅ Payment uploaded successfully! Waiting for review.";
        _isPaymentConfirmed = true;
      } else {
        _confirmationMessage = "❌ Upload failed. Please try again.";
      }
    } catch (e) {
      _confirmationMessage = "❌ Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}