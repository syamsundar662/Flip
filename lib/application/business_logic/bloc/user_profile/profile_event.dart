part of 'profile_bloc.dart';

class ProfileEvent {}

class UserDataFetchEvent extends ProfileEvent {
  final String id;
  UserDataFetchEvent({required this.id});
}

class ProfilePostDataFetchEvent extends ProfileEvent {
  final String id;
  ProfilePostDataFetchEvent({required this.id});
}

class SwitchBetweenPostsButtonEvent extends ProfileEvent{}

class ProfileThoughtFetchEvent extends ProfileEvent{
  final String id;

  ProfileThoughtFetchEvent({required this.id});
}
