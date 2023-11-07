import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final TextEditingController textContentController = TextEditingController();
  PostBloc() : super(PostInitial()) {
    on<PostEvent>((event, emit) {
    });
  }
}
