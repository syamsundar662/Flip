part of 'profile_post_bloc.dart';

class ProfilePostState {}

final class ProfileInitial extends ProfilePostState {}

final class ProfileFetchingState extends ProfilePostState {}

final class ProfileFetchedState extends ProfilePostState {
  final List<PostModel> model;
  ProfileFetchedState({required this.model});
}

final class ProfileFetchingErrorState extends ProfilePostState {}
