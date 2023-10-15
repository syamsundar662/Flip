part of 'auth_bloc.dart';

// class AuthEvent {}

// class SignUpRequest extends AuthEvent{
//   final String email; 
//   final String password; 
//   SignUpRequest(this.email,this.password);
// }

// class LoginRequest extends AuthEvent{
//   final String email; 
//   final String password; 
//   LoginRequest(this.email,this.password);
// }


class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
}
class SignUpWithGoogle extends AuthEvent{}