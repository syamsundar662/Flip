import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
part 'fetch_event.dart';
part 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  FetchBloc() : super(FetchInitial()) {
    on<HomeFetchPostEvent>(homePostDataFetchEvent);
  }

  FutureOr<void> homePostDataFetchEvent(
      HomeFetchPostEvent event, Emitter<FetchState> emit) async {
    emit(HomeDataFetchingState());
    try{
      final response = await Post().getAllPosts();
     return emit(HomeDataFechedState(model: response));
    }catch (e){
      emit(ErrorFetchingHomeData()); 

    }
  }
}
