class UserModel {
  final String? postId;
  final String userId;
  final String username;
  final String email;
  final String? displayName;
  final String? bio;
  final List saves;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final List followers;
  final List following;
  final List<String>? posts;

  UserModel({ 
    this.postId,
    this.displayName,
    this.bio,
    required this.saves,
    this.posts,
    this.coverImageUrl = '',
    this.profileImageUrl = '',
    required this.followers,
    required this.following,
    required this.userId,
    required this.username,
    required this.email,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['userId'],
        bio: json['bio'] ?? '',
        email: json['email'],
        saves: List.from(json['saves'] ?? []),
        postId: json['postId'] ?? '',
        username: json['username'] ?? '',
        displayName: json['displayName'] ?? '',
        coverImageUrl: json['coverImageUrl'] ?? '',
        profileImageUrl: json['profileImageUrl'] ?? '',
        followers: List.from(json['followers'] ?? []),
        following: List.from(json['following'] ?? []),
        posts: List.from(json['posts'] ?? []));
  }
}
