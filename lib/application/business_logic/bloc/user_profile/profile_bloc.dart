import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flip/domain/repositories/post_repository/post_repository.dart';
import 'package:flip/domain/repositories/user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository;
  PostRepository postRepository;
  ProfileBloc(this.postRepository, this.userRepository)
      : super(ProfileInitial()) {
    on<UserDataFetchEvent>(userDataFetchEvent);
    on<ProfilePostDataFetchEvent>(profilePostFetchEvent);
    on<ProfileThoughtFetchEvent>(profileThoughtFetchEvent);
  }
  FutureOr<void> userDataFetchEvent(
      UserDataFetchEvent event, Emitter<ProfileState> emit) async {
    emit(UserDataFetchingState());
    final response = await userRepository.fetchDataByUser(event.id);
    return emit(UserDataFetchedState(model: response!));
  }

  FutureOr<void> profilePostFetchEvent(
      ProfilePostDataFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileFetchingState());
    try {
      final response = await postRepository.fetchPostDataByUser(event.id);
      emit(ProfileFetchedState(model: response));
    } catch (e) {
      emit(ProfileFetchingErrorState());
    }
  }

  FutureOr<void> profileThoughtFetchEvent(
      ProfileThoughtFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileThoughtFetchingState());
    final response = await postRepository.fetchThoughtByUser(event.id);
    emit(ProfileThoughtFetchedState(model: response));
  }
}
