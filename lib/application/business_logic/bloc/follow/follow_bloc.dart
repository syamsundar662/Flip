import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/models/user_model/user_model.dart';
import 'package:flip/data/repositories/follow_repository/follow_repository.dart';
part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {

  FollowRepository followRepository;
  FollowBloc(this.followRepository) : super(FollowInitial()) {
     on<FetchFriendsListEvent>(fetchFriendsList);
    on<RemoveFollower>(removeFollower);
  }

  FutureOr<void> fetchFriendsList(
      FetchFriendsListEvent event, Emitter<FollowState> emit) async {
    List<UserModel> friends = [];
    if (Friend.follower == event.friend) {
      friends = await followRepository.getFollowersList(uid: event.userId);
    } else {
      friends = await followRepository.getFollowingList(uid: event.userId);
    }
    emit(FriendsListFetchSuccess(freinds: friends));
  }

  FutureOr<void> removeFollower(
      RemoveFollower event, Emitter<FollowState> emit) async {
    await followRepository.removeFollower(
        uid: FirebaseAuth.instance.currentUser!.uid, followerId: event.userId);
    List<UserModel> friends = [];
    friends = await followRepository.getFollowersList(
        uid: FirebaseAuth.instance.currentUser!.uid);
    emit(FriendsListFetchSuccess(freinds: friends, isRemoved: true));
  }




  
}
