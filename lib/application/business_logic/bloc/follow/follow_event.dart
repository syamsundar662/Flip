part of 'follow_bloc.dart';

class FollowEvent {}
class FetchFriendsListEvent extends FollowEvent {
  final Friend friend;
  final String userId;
  FetchFriendsListEvent({required this.friend, required this.userId});
}

class RemoveFollower extends FollowEvent {
  final String userId;
  RemoveFollower({required this.userId});
}
