class UserRepositoryModel {
  final String? postId;
  final String userId;
  final String? username;
  final String email;
  final String? displayName;
  final String? bio;
  final String? saves;
  final String? profileImageUrl;
  final List<String>? followers;
  final List<String>? following;
  final List<String>? posts;

  UserRepositoryModel({
    this.postId, 
    this.displayName,
    this.bio,
    this.saves,
    this.profileImageUrl, 
    this.followers,
    this.following,
    this.posts,
    required this.userId,
    required this.username,
    required this.email,
  });
}
