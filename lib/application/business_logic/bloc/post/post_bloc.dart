import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/utils/image/image_picker.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flip/data/repositories/post_repository/post_repository.dart';
import 'package:flip/data/repositories/user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  UserRepository userRepository;
  PostRepository postRepository;
  TextEditingController textContentController = TextEditingController();
  PostBloc(this.postRepository, this.userRepository) : super(PostInitial()) {
    on<PostImageSelectionEvent>(postImageSelectionEvent);
    on<PostThoughtsEvents>(postThoughtsEvents);
    on<PostAddingEvent>(postAddingEvent);
    on<PostDeleteEvent>(postDeleteEvent);
  }

  Future<void> postImageSelectionEvent(
      PostImageSelectionEvent event, Emitter<PostState> emit) async {
    emit(PostInitial());
    final imagePath = await PickImage().multiImagePicker();
    if (imagePath.isNotEmpty) {
      emit(PostImageSelectedState(selectedImageFile: imagePath));
    }
  }

  FutureOr<void> postThoughtsEvents(
      PostThoughtsEvents event, Emitter<PostState> emit) async {
    emit(PostAdditionLoadingState());
    final currentUser = await userRepository
        .fetchDataByUser(FirebaseAuth.instance.currentUser!.uid);
    event.model.username = currentUser == null ? '' : currentUser.username;
    await postRepository.createPost(event.model, event.userId);
    return emit(PostThoughtsAdditionSuccessState());
  }

  FutureOr<void> postAddingEvent(
      PostAddingEvent event, Emitter<PostState> emit) async {
    emit(PostAdditionLoadingState());
    final selectdImagesUrls =
        await PickImage().uploadImages(event.model.imageUrls);
    final currentUser = await userRepository
        .fetchDataByUser(FirebaseAuth.instance.currentUser!.uid);
    //user profile imageurl should be here
    event.model.username = currentUser == null ? '' : currentUser.username;
    event.model.imageUrls = selectdImagesUrls;
    await postRepository.createPost(event.model, event.userId);
    emit(PostAdditionSuccessState());
  }

  FutureOr<void> postDeleteEvent(
      PostDeleteEvent event, Emitter<PostState> emit) async {
    emit(PostDeletionState());
    await postRepository.deletePost(event.postId,event.userId);
    emit(PostDeleteSuccessState());
  }
}
