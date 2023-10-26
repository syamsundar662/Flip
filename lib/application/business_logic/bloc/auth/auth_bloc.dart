import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flip/domain/repositories/auth_repo/auth_repository.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpEvent>(signUpEvent);

    on<SignInEvent>(signInEvent);

    on<SignUpWithGoogle>(signUpWithGoogle);
  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthState(isSaving: true, returnValue: ''));
    final authenticationResult =
        await authRepository.signUp(event.email, event.password);
        log(authenticationResult);
    emit(AuthState(isSaving: false, returnValue: authenticationResult));
  }

  FutureOr<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthState(isSaving: true, returnValue: '', isLogin: true));
    final signInAuthenthication =
        await authRepository.signIn(event.email, event.password);
    emit(AuthState(
        isSaving: false, returnValue: signInAuthenthication, isLogin: true));
  }

  FutureOr<void> signUpWithGoogle(
      SignUpWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthState(isSaving: false, returnValue: ''));
    final String result = await authRepository.signinWithGoogle();
    emit(AuthState(isSaving: false, returnValue: result));
  }
}
