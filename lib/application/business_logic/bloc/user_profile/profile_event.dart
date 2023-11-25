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

class ProfileThoughtFetchEvent extends ProfileEvent {
  final String id;

  ProfileThoughtFetchEvent({required this.id});
}
class ProfileSavedPostFetchEvent extends ProfileEvent {
  final String id;

  ProfileSavedPostFetchEvent({required this.id});
}

// class UserProfileInitialEvent extends ProfileEvent { 
//   final int tap;

//   SwitchBetweenPostAndThoughts({required this.tap});
// }
