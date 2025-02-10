import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/posts.dart';
import '../providers/posts.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Consumer<PostProviderr>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: postProvider.posts.length,
              itemBuilder: (context, index) {
                Post post = postProvider.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.content),
                  trailing: Text(post.username),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // مثال لإضافة منشور جديد
          Post newPost = Post(
            title: "New Title",
            content: "New Content",
            username: "zaid",
          );
          Provider.of<PostProviderr>(context, listen: false).addPost(newPost);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}