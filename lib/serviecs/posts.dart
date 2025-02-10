import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/posts.dart';

class PostService {
  final String apiUrl = "http://192.168.137.194:5000/api/Post";

  // جلب المنشورات
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();
      return posts;
    } else {
      throw "Failed to load posts";
    }
  }

  // إضافة منشور جديد
  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to create post";
    }
  }
}