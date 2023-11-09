part of 'profile_bloc.dart';

class ProfileEvent {}

class UserDataFetchEvent extends ProfileEvent {
  final String id;

  UserDataFetchEvent({required this.id});
}
