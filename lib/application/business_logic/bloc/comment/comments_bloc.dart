import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flip/application/business_logic/bloc/comment/comments_state.dart';
import 'package:flip/data/models/comment_model/comment_model.dart';
import 'package:flip/data/repositories/comment_repository/comment_repository.dart';
import 'package:flutter/material.dart';
part 'comments_event.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentRepository commentRepository;
  TextEditingController commentController = TextEditingController();
  CommentsBloc(this.commentRepository) : super(CommentsInitial(comments: [])) {
    on<CommentsAddButtonEvent>(commentsAddButtonEvent);
    on<CommentsFetchEvent>(commentsFetchEvent);
    on<CommentsDeleteEvent>(commentsDeleteEvent);
  }

  List<CommentWithUserProfile> comments = [];

  FutureOr<void> commentsAddButtonEvent(
      CommentsAddButtonEvent event, Emitter<CommentsState> emit) async {
    await commentRepository.addComments(event.model, event.model.postId);
    final comments = await commentRepository.fetchComments(event.model.postId);
    await commentRepository.fetchUser(comments).then((commentsData) {
      emit(CommentsAddSuccessState(comments: commentsData));
    });
    commentController.clear();
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

  FutureOr<void> commentsDeleteEvent(CommentsDeleteEvent event, Emitter<CommentsState> emit)async{
  comments.removeWhere((comment) => comment.comment.commentId==event.comment.commentId);
  emit(CommentDeleteState(comments: comments));
  await commentRepository.deleteComment(event.comment); 

    final commentsResponse = await commentRepository.fetchComments(event.comment.postId);
    await commentRepository.fetchUser(commentsResponse).then((value) {
      comments = value;
      emit(CommentsFetchedState(comments: value));
    }); 
  }
} 
 