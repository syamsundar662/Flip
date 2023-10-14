part of 'auth_bloc.dart';

class AuthState {
  bool isSaving;
  String returnValue;
  AuthState({required this.isSaving,required this.returnValue});
}

final class AuthInitial extends AuthState {
  AuthInitial():super(isSaving: false,returnValue:'');
}

