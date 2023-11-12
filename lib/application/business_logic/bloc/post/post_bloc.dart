import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/utils/image/image_picker.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/cupertino.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final TextEditingController textContentController = TextEditingController();
  PostBloc() : super(PostInitial()) {
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
    await Post().createPost(event.model,event.userId);
    return emit(PostThoughtsAdditionSuccessState());
  }

  FutureOr<void> postAddingEvent(
      PostAddingEvent event, Emitter<PostState> emit) async {
    emit(PostAdditionLoadingState());
    final selectdImagesUrls =
        await PickImage().uploadImages(event.model.imageUrls);
    final currentUser =
        await Post().fetchDataByUser(FirebaseAuth.instance.currentUser!.uid);
    //user profile imageurl should be here
    event.model.username = currentUser == null ? '' : currentUser.username;
    event.model.imageUrls = selectdImagesUrls;
    await Post().createPost(event.model,event.userId);
    emit(PostAdditionSuccessState());
  }

  FutureOr<void> postDeleteEvent(
      PostDeleteEvent event, Emitter<PostState> emit) async {
    await Post().deletePost(event.postId);
    emit(PostDeletionState());
    emit(PostDeleteSuccessState());
  }
}
