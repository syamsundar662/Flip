import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flip/data/models/user_model/user_model.dart';
import 'package:flip/data/repositories/post_repository/post_repository.dart';
import 'package:flip/data/repositories/save_post_repository/save_post_repository.dart';
import 'package:flip/data/repositories/user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository;
  PostRepository postRepository;
  SavePostRepository savePostRepository;
  ProfileBloc(this.postRepository, this.userRepository, this.savePostRepository)
      : super(ProfileInitial()) {
    on<UserDataFetchEvent>(userDataFetchEvent);
    on<ProfilePostDataFetchEvent>(profilePostFetchEvent);
    on<ProfileThoughtFetchEvent>(profileThoughtFetchEvent);
    on<ProfileSavedPostFetchEvent>(profileSavedPostFetchEvent);
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

  FutureOr<void> profileSavedPostFetchEvent(
      ProfileSavedPostFetchEvent event, Emitter<ProfileState> emit) async {
    final savesPostsResponse =
        await savePostRepository.fetchSavedPosts(event.id);
    emit(ProfileSavedPostFetchedState(postModel: savesPostsResponse));
  }
}
