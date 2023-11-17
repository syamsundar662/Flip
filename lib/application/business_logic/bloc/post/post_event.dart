part of 'post_bloc.dart';

@immutable
class PostEvent {}

class PostImageSelectionEvent extends PostEvent {}

class PostThoughtsEvents extends PostEvent {
  final PostModel model;
  final String userId;
  PostThoughtsEvents({required this.model, required this.userId});
}

class PostOpenCameraEvent extends PostEvent {}

class PostAddingEvent extends PostEvent {
  final PostModel model;

  final String userId;

  PostAddingEvent({required this.model, required this.userId});
}

class PostScreenCloseEvent extends PostEvent {}

class PostDeleteEvent extends PostEvent {
  final String postId;
  final String userId;

  PostDeleteEvent(this.userId, {required this.postId});
}
