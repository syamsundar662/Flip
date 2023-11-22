import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/repositories/comment_repository/comment_repository.dart';
import 'package:flutter/material.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentRepository commentRepository;
  TextEditingController commentController = TextEditingController();
  CommentsBloc(this.commentRepository) : super(CommentsInitial(comments: [])) {
    on<CommentsAddButtonEvent>(commentsAddButtonEvent);
    on<CommentsFetchEvent>(commentsFetchEvent);
  }

  List<CommentWithUserProfile> comments = [];

  FutureOr<void> commentsAddButtonEvent(
      CommentsAddButtonEvent event, Emitter<CommentsState> emit) async {
    await commentRepository.addComments(event.model, event.model.postId);


    
    final comments = await commentRepository.fetchComments(event.model.postId);
    await commentRepository.fetchUser(comments).then((commentsData) =>
        emit(CommentsAddSuccessState(comments: commentsData)));
  }

  FutureOr<void> commentsFetchEvent(
      CommentsFetchEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsFetchingState(comments: []));
    final response = await commentRepository.fetchComments(event.postId);
    await commentRepository.fetchUser(response).then((value) {
      comments = value;
      emit(CommentsFetchedState(comments: value));
    });
  }
}
