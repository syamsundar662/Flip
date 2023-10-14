part of 'obscure_bloc.dart';

class ObscureState {
  bool obscureState;

  ObscureState({required this.obscureState});
}

final class ObscureInitial extends ObscureState {
  ObscureInitial():super(obscureState: false );
}
