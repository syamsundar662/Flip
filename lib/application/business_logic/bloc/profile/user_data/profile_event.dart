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
