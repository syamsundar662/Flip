import 'package:flip/data/models/comment_model/comment_model.dart';

class CommentsState {
  final List<CommentWithUserProfile>? comments;
  final bool? isAdding;

  CommentsState({
    required this.comments,
    this.isAdding,
  });
}

final class CommentsInitial extends CommentsState {
  CommentsInitial({required super.comments});
}

final class CommentsAddingState extends CommentsState {
  CommentsAddingState({required super.comments});
}

final class CommentsAddSuccessState extends CommentsState {
  CommentsAddSuccessState({required super.comments});
}

final class CommentsAddFailState extends CommentsState {
  CommentsAddFailState({required super.comments});
}

final class CommentsFetchingState extends CommentsState {
  CommentsFetchingState({required super.comments});
}

final class CommentsFetchedState extends CommentsState {
  CommentsFetchedState({required super.comments});
}
final class CommentDeleteState extends CommentsState {
  CommentDeleteState({required super.comments});
}
