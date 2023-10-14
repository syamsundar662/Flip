import 'package:bloc/bloc.dart';

part 'obscure_event.dart';
part 'obscure_state.dart';

class ObscureBloc extends Bloc<ObscureEvent, ObscureState> {
  ObscureBloc() : super(ObscureInitial()) {
    on<ObscureEvent>((event, emit) {
      emit(ObscureState(obscureState: true));
      emit(ObscureState(obscureState: false));
    });
  }
}
