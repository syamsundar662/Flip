part of 'auth_bloc.dart';

class AuthState {
  bool isSaving;
  bool isLogin;
  String returnValue;
  AuthState({required this.isSaving,required this.returnValue,this.isLogin=false});
}

final class AuthInitial extends AuthState {
  AuthInitial():super(isSaving: false,returnValue:'');
}

