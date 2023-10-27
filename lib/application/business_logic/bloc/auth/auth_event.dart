part of 'auth_bloc.dart';


class AuthEvent {}

class LogInEvent extends AuthEvent {
  final LogInModel logIn;
  LogInEvent({required this.logIn});
}

class SignUpEvent extends AuthEvent {
  final SignUpModel signUp;
  SignUpEvent({required this.signUp});
}

class SignUpWithGoogleEvent extends AuthEvent{}

class EmailVarificationPopUp extends AuthState{}

class VerifyWithEmailEvent extends AuthEvent{}

class PasswordResetEvent extends AuthEvent{}