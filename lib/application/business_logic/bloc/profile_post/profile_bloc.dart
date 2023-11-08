import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfilePostDataFetchEvent>(profileDataFetchEvent);
  }

  FutureOr<void> profileDataFetchEvent(ProfilePostDataFetchEvent event, Emitter<ProfileState> emit)async {
    emit(ProfileFetchingState());
    try{
    final response = await Post().fetchDataByUser(event.id);
    emit(ProfileFetchedState(model: response));
    }catch (e){ 
      emit(ProfileFetchingErrorState());
    }
  }
}
