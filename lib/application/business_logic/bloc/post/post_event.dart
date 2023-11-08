part of 'post_bloc.dart';

@immutable
class PostEvent {}

class PostImageSelectionEvent extends PostEvent {}

class PostThoughtsEvents extends PostEvent {
  final PostModel model;
  PostThoughtsEvents({required this.model});
}
class PostOpenCameraEvent extends PostEvent {
 
}

class PostAddingEvent extends PostEvent {
   final PostModel model;

  PostAddingEvent({required this.model});
}

class PostScreenCloseEvent extends PostEvent {}
