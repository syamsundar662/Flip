part of 'profile_bloc.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class UserProfileInitialState extends ProfileState {
  final int value;
 
  UserProfileInitialState({this.value = 0});
}

class UserDataFetchingState extends ProfileState {}

class UserDataFetchedState extends ProfileState {
  final UserModel model;

  UserDataFetchedState({required this.model});
}

class UserDataFetchingErrorState extends ProfileState {}

class ProfileFetchingState extends ProfileState {}

class ProfileFetchedState extends ProfileState {
  final List<PostModel> model;

  ProfileFetchedState({required this.model});
}

class ProfileFetchingErrorState extends ProfileState {}

class ProfileThoughtFetchingState extends ProfileState {}

class ProfileThoughtFetchedState extends ProfileState {
  final List<PostModel> model;

  ProfileThoughtFetchedState({required this.model});
}

class ProfileSavedPostFetchedState extends ProfileState {
  final List<PostModel> postModel;

  ProfileSavedPostFetchedState({required this.postModel});
}

class ProfileSavedPostFetchingState extends ProfileState {}
