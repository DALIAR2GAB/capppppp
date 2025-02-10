import 'package:flutter/material.dart';
import '../models/posts.dart';
import '../serviecs/posts.dart';


class PostProviderr with ChangeNotifier {
  final PostService _postService = PostService();
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  // جلب المنشورات من الـ API
  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = await _postService.getPosts();
    } catch (e) {
      // التعامل مع الأخطاء
      print("Error fetching posts: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // إضافة منشور جديد
  Future<void> addPost(Post post) async {
    try {
      await _postService.createPost(post);
      await fetchPosts(); // تحديث القائمة بعد إضافة منشور جديد
    } catch (e) {
      // التعامل مع الأخطاء
      print("Error adding post: $e");
    }
  }
}