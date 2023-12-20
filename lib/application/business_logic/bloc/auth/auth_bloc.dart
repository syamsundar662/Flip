import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/models/login_model/login_model.dart';
import 'package:flip/data/models/sign_up_model/sign_up_model.dart';
import 'package:flip/data/repositories/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordResetController = TextEditingController();

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpEvent>(signUpEvent);

    on<LogInEvent>(signInEvent);

    on<SignUpWithGoogleEvent>(signUpWithGoogle);

    on<VerifyWithEmailEvent>(verifyWithEmail);

    on<PasswordResetEvent>(passwordResetEvent);
  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final AuthenticationResults signUpResponse =
        await authRepository.signUp(event.signUp);
    if (signUpResponse == AuthenticationResults.signUpSuccess) {
      emit(AuthSuccessState(authResponse: signUpResponse));
    } else {
      emit(AuthErrorState(authResponse: signUpResponse));
    }
  }

  FutureOr<void> signInEvent(LogInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final AuthenticationResults logInResponse =
        await authRepository.signIn(event.logIn);
    logInResponse == AuthenticationResults.logInSuccess
        ? emit(AuthSuccessState(authResponse: logInResponse))
        : emit(AuthErrorState(authResponse: logInResponse));
  }

  FutureOr<void> signUpWithGoogle(
      SignUpWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final AuthenticationResults googleSignInResponse =
        await authRepository.signInWithGoogle();
    googleSignInResponse == AuthenticationResults.googleSignInSuccess
        ? emit(AuthSuccessState(authResponse: googleSignInResponse))
        : emit(AuthErrorState(authResponse: googleSignInResponse));
  }

  FutureOr<void> verifyWithEmail(
      VerifyWithEmailEvent event, Emitter<AuthState> emit) async {
    final AuthenticationResults verifiedEmailResponse =
        await authRepository.verifyEmail();
    if (verifiedEmailResponse == AuthenticationResults.verificationSuccess) {
      emit(EmailVerifiedSuccessState());
    }
  }

  FutureOr<void> passwordResetEvent(
      PasswordResetEvent event, Emitter<AuthState> emit) async {
        emit(AuthLoadingState());
    final String resetPasswordResponse =
        await authRepository.resetPassword(event.email);
      emit(PasswordResetSuccessState(response: resetPasswordResponse)); 
    
  }
}
