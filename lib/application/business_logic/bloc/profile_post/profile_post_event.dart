part of 'profile_post_bloc.dart';

class ProfilePostEvent {}

class ProfilePostDataFetchEvent extends ProfilePostEvent{
  final String id ;
  ProfilePostDataFetchEvent({required this.id});
}
