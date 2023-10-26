part of 'auth_bloc.dart';


class AuthEvent {}

class SignInEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}

class SignUpWithGoogleEvent extends AuthEvent{}

class VerifyWithEmailEvent extends AuthEvent{}

class PasswordResetEvent extends AuthEvent{}