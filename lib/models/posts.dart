class Post {
  final String title;
  final String content;
  final String username;

  Post({
    required this.title,
    required this.content,
    required this.username,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      content: json['content'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'username': username,
    };
  }
}