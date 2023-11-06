part of 'post_bloc.dart';

@immutable
 class PostEvent {}

class PostImageSelectionEvent extends PostEvent {}

class PostOpenCameraEvent extends PostEvent {}

class PostAddingEvent extends PostEvent {}

class PostScreenCloseEvent extends PostEvent {}
