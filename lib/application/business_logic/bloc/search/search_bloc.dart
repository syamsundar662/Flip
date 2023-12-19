import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/repositories/post_repository/post_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  PostRepository postRepository;
  SearchBloc(this.postRepository) : super(SearchInitial()) {
    on<SearchPageInitalFeedsFetchEvent>(searchPageInitalFeedsFetchEvent);
  }

  FutureOr<void> searchPageInitalFeedsFetchEvent(
      SearchPageInitalFeedsFetchEvent event, Emitter<SearchState> emit) async {
    emit(SearchPageInitialFeedFechingEvent());
    final response = await postRepository.fetchAllImagePosts();
    emit(SearchPageInitialFeedFechedEvent(postDatas: response));
  }
}
