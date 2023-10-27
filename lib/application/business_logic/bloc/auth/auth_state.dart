part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState{}

class AuthSuccessState extends AuthState{
  final AuthenticationResults authResponse;
  AuthSuccessState({required this.authResponse});
}

class AuthErrorState extends AuthState{
  final AuthenticationResults authResponse;
  AuthErrorState({required this.authResponse});
}
class EmailVerifiedSuccessState extends AuthState{}

class PasswordResetSuccessState extends AuthState{}

