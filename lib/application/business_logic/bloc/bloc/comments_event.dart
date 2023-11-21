part of 'comments_bloc.dart';

class CommentsEvent {}

class CommentsAddButtonEvent extends CommentsEvent {
  final Comments model;
  CommentsAddButtonEvent({required this.model});
}

class CommentsFetchEvent extends CommentsEvent {
  final String postId;
  CommentsFetchEvent({required this.postId});
}
