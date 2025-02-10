import 'package:flutter/material.dart';

import '../models/homepage.dart';
import '../serviecs/homepage.dart';

class PostProvider with ChangeNotifier {
  final PostService _postService = PostService();
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await _postService.getPosts();
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleLike(int index) {
    _posts[index].isLiked = !_posts[index].isLiked;
    notifyListeners();
  }
}
