// lib/models/post.dart

class Post {
  final String userName;
  final String userRole;
  final String profileImageUrl;
  final String timestamp;
  final String content;
  final List<String>? postImageUrl;
  final String likes;
  final Map<String, dynamic> messages;

  Post({
    required this.userName,
    required this.userRole,
    required this.profileImageUrl,
    required this.timestamp,
    required this.content,
    this.postImageUrl,
    required this.likes,
    required this.messages,
  });
}
