class Post {
  final String username;
  final String content;
  bool isLiked;

  Post({required this.username, required this.content, this.isLiked = false});

  // تحويل البيانات من JSON إلى كائن Dart
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['user']?['username'] ?? 'Unknown', // هنا نصل إلى `username` داخل `user`
      content: json['content'] ?? '',
    );
  }
}
