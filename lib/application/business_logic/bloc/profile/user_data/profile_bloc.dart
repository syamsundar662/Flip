import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UserDataFetchEvent>(userDataFetchEvent);
    on<ProfilePostDataFetchEvent>(profileDataFetchEvent);
  }

  FutureOr<void> userDataFetchEvent(
      UserDataFetchEvent event, Emitter<ProfileState> emit) async {
    emit(UserDataFetchingState());
    final response = await Post().fetchDataByUser(event.id);
    return emit(UserDataFetchedState(model: response!));
  }

  FutureOr<void> profileDataFetchEvent(
      ProfilePostDataFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileFetchingState());
    try {
      final response = await Post().fetchPostDataByUser(event.id);
      emit(ProfileFetchedState(model: response));
    } catch (e) {
      emit(ProfileFetchingErrorState());
    }
  }
}
