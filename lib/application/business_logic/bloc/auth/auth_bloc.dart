import 'package:bloc/bloc.dart';
import 'package:flip/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
 
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>((event, emit)async {
      emit(AuthState(isSaving: true,returnValue: ''));
      final authenticationResult = await AuthRepository().signUp(event.email, event.password);
      emit(AuthState(isSaving: false,returnValue: authenticationResult));
    });
    on<SignInEvent>((event, emit) async {
      emit(AuthState(isSaving: true, returnValue: '',isLogin: true)); 
      final signInAuth = await AuthRepository().signIn(event.email, event.password);
      emit(AuthState(isSaving: false, returnValue: signInAuth,isLogin: true));
    });
    on<SignUpWithGoogle>((event, emit) {
      emit(AuthState(isSaving: false, returnValue: ''));
      
    });

  }
}
