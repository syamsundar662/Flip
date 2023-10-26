part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState{}

class AuthSuccessState extends AuthState{}

class AuthErrorState extends AuthState{}

class EmailVerifiedSuccessState extends AuthState{}

class PasswordResetSuccessState extends AuthState{}

