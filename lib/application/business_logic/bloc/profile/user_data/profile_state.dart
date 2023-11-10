part of 'profile_bloc.dart';

class ProfileState {}
class ProfileInitial extends ProfileState {}
class UserDataFetchingState extends ProfileState{}
class UserDataFetchedState extends ProfileState{
  final UserRepositoryModel model;

  UserDataFetchedState({required this.model});
}
class UserDataFetchingErrorState extends ProfileState{}


final class ProfileFetchingState extends ProfileState {}

final class ProfileFetchedState extends ProfileState {
  final List<PostModel> model;
  ProfileFetchedState({required this.model});
}

final class ProfileFetchingErrorState extends ProfileState {}