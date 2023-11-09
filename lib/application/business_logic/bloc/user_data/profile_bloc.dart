import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/user_model/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UserDataFetchEvent>(userDataFetchEvent);
  }

  FutureOr<void> userDataFetchEvent(UserDataFetchEvent event, Emitter<ProfileState> emit) async{
    emit(UserDataFetchingState());
    final response = await Post().fetchDataByUser(event.id);
    return emit(UserDataFetchedState(model: response!)); 
  }
}
