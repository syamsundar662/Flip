import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flip/data/repositories/post_repository/post_repository.dart';
part 'fetch_event.dart';
part 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  PostRepository postRepository;
  FetchBloc(this.postRepository) : super(FetchInitial()) {
    on<HomeFetchPostEvent>(homePostDataFetchEvent);
  }

  FutureOr<void> homePostDataFetchEvent(
      HomeFetchPostEvent event, Emitter<FetchState> emit) async {
    emit(HomeDataFetchingState());
    try {
      final response = await postRepository.getPostsWithUserData();
      return emit(HomeDataFechedState(model: response));
    } catch (e) {
      emit(ErrorFetchingHomeData());
    }
  }
}
