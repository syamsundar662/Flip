class UserRepositoryModel {
  final String? postId;
  final String userId;
  final String username;
  final String email;
  final String? displayName;
  final String? bio;
  final String? saves;
  final String? profileImageUrl;
  final String ?coverImageUrl;
  final List<String>?followers;
  final List<String>? following;
  final List<String>? posts;

  UserRepositoryModel({
    this.postId,
    this.displayName,
    this.bio,
    this.saves,
    this.posts,
    this.coverImageUrl = '',
    this.profileImageUrl = '',
    this.followers,
    this.following,
    required this.userId,
    required this.username,
    required this.email,
  });
  factory UserRepositoryModel.fromJson(Map<String, dynamic> json) {
    return UserRepositoryModel(
        userId: json['userId'],
        bio: json['bio'] ?? '', 
        email: json['email'],
        saves: json['saves'] ?? '',
        postId: json['postId'],
        username: json['username'] ?? '',
        displayName: json['displayName'] ?? '',
        coverImageUrl: json['coverImageUrl'] ?? '',
        profileImageUrl: json['profileImageUrl'] ?? '',
        followers: List.from(json['followers']??[]),
        following: List.from(json['following']??[]),
        posts: List.from(json['posts']??[]));
  }
}
