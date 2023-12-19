part of 'fetch_bloc.dart';

class FetchState {}

class FetchInitial extends FetchState {}

class HomeDataFetchingState extends FetchState {}

class HomeDataFechedState extends FetchState {
  final List<FetchPostWithUserProfile> model;
  HomeDataFechedState({required this.model});
}
class ErrorFetchingHomeData extends FetchState {}
