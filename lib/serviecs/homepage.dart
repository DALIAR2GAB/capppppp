import 'package:dio/dio.dart';

import '../models/homepage.dart';

class PostService {
  final Dio dio = Dio();
  final String apiUrl = "http://192.168.137.194:5000/api/Post/GetPostsForPatients";


  Future<List<Post>> getPosts() async {
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<Post> posts = (response.data as List)
            .map((data) => Post.fromJson(data))
            .toList();
        return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
