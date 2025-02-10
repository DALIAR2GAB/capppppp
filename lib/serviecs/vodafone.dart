import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import '../models/vodafone.dart';

class VodafoneCashService {
  static const String baseUrl = "http://192.168.137.194:5000/api/VodafoneCash/upload";

  static Future<VodafoneCashModel?> uploadImage(File image) async {
    try {
      var uri = Uri.parse('$baseUrl/upload');
      var request = http.MultipartRequest('POST', uri);

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        image.path,
        contentType: MediaType('image', 'png'),
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseData);
        return VodafoneCashModel.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}