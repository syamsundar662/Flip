part of 'search_bloc.dart';

class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchPageInitialFeedFechingEvent extends SearchState {}

final class SearchPageInitialFeedFechedEvent extends SearchState {
  final List<PostModel> postDatas;

  SearchPageInitialFeedFechedEvent({required this.postDatas});
}
