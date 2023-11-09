part of 'profile_bloc.dart';

class ProfileState {}
class ProfileInitial extends ProfileState {}
class UserDataFetchingState extends ProfileState{}
class UserDataFetchedState extends ProfileState{
  final UserRepositoryModel model;

  UserDataFetchedState({required this.model});
}
class UserDataFetchingErrorState extends ProfileState{}
