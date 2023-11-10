import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_delete_event.dart';
part 'post_delete_state.dart';

class PostDeleteBloc extends Bloc<PostDeleteEvent, PostDeleteState> {
  PostDeleteBloc() : super(PostDeleteInitial()) {
    on<PostDeleteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
