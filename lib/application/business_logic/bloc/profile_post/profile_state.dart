part of 'profile_bloc.dart';

class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileFetchingState extends ProfileState {}

final class ProfileFetchedState extends ProfileState {
  final List<PostModel> model;
  ProfileFetchedState({required this.model});
}

final class ProfileFetchingErrorState extends ProfileState {}
