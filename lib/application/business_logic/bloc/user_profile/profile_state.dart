part of 'profile_bloc.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class UserDataFetchingState extends ProfileState {}

class UserDataFetchedState extends ProfileState {
  final UserRepositoryModel model;
  UserDataFetchedState({required this.model});
}

class UserDataFetchingErrorState extends ProfileState {}

class ProfileFetchingState extends ProfileState {}

class ProfileFetchedState extends ProfileState {
  final List<PostModel> model;
  ProfileFetchedState({required this.model});
}

class ProfileFetchingErrorState extends ProfileState {}

class SwitchBetweenPostesDoneState extends ProfileState {}

class ProfileThoughtFetchingState extends ProfileState {}

class ProfileThoughtFetchedState extends ProfileState {
  final List<PostModel> model;

  ProfileThoughtFetchedState({required this.model});
}
