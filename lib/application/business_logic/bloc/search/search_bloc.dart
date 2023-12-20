import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flip/domain/repositories/post_repository/post_repository.dart';
import 'package:flip/domain/repositories/user_repository/user_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  PostRepository postRepository;

  UserRepository userRepository;
  SearchBloc(this.postRepository, this.userRepository)
      : super(SearchInitial()) {
    on<SearchPageInitalFeedsFetchEvent>(searchPageInitalFeedsFetchEvent);
    on<UserSearchEvent>(userSearchEvent);
    on<InitialSearch>(initialSearch);
  }

  FutureOr<void> searchPageInitalFeedsFetchEvent(
      SearchPageInitalFeedsFetchEvent event, Emitter<SearchState> emit) async {
    emit(SearchPageInitialFeedFechingEvent());
    final response = await postRepository.fetchAllImagePosts();
    emit(SearchPageInitialFeedFechedEvent(postDatas: response));
  }

  FutureOr<void> userSearchEvent(
      UserSearchEvent event, Emitter<SearchState> emit) async {
    SearchLoading();
    final users = await userRepository.searchUsersByUsername(event.query);
    users.isEmpty
        ? emit(SearchResultEmpty())
        : emit(SearchResultFound(users: users));
  }

  FutureOr<void> initialSearch(InitialSearch event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }
}
