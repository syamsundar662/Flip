part of 'post_bloc.dart';

@immutable
class PostState {}

class PostInitial extends PostState {}

class PostImageSelectedState extends PostState {
  final List<File> selectedImageFile;
  PostImageSelectedState({required this.selectedImageFile});
}
class PostThoughtsAdditionSuccessState extends PostState {}

class PostAdditionSuccessState extends PostState {}

class PostAdditionErrorState extends PostState {}

class PostAdditionLoadingState extends PostState {}
