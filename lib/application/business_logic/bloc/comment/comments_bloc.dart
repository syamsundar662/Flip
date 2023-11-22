import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/repositories/post_repository/post_repository.dart';
import 'package:flutter/material.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  PostRepository postRepository;
  TextEditingController commentController = TextEditingController();
  CommentsBloc(this.postRepository) : super(CommentsInitial(comments: [])) {
    on<CommentsAddButtonEvent>(commentsAddButtonEvent);
    on<CommentsFetchEvent>(commentsFetchEvent);
  }

  List<CommentWithUserProfile> comments = [];

  FutureOr<void> commentsAddButtonEvent(
      CommentsAddButtonEvent event, Emitter<CommentsState> emit) async {
    await postRepository.addComments(event.model, event.model.postId);


    
    final comments = await postRepository.fetchComments(event.model.postId);
    await postRepository.fetchUser(comments).then((commentsData) =>
        emit(CommentsAddSuccessState(comments: commentsData)));
  }

  FutureOr<void> commentsFetchEvent(
      CommentsFetchEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsFetchingState(comments: []));
    final response = await postRepository.fetchComments(event.postId);
    await postRepository.fetchUser(response).then((value) {
      comments = value;
      emit(CommentsFetchedState(comments: value));
    });
  }
}
