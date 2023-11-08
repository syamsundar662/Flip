part of 'profile_bloc.dart';

class ProfileEvent {}

class ProfilePostDataFetchEvent extends ProfileEvent{
  final String id ;
  ProfilePostDataFetchEvent({required this.id});
}
