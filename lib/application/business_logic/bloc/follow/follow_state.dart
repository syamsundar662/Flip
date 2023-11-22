part of 'follow_bloc.dart';

class FollowState {}

final class FollowInitial extends FollowState {}

class FriendsListFetchSuccess extends FollowState {
  final List<UserModel> freinds;
  final bool isRemoved;
  FriendsListFetchSuccess({required this.freinds, this.isRemoved = false});
}
