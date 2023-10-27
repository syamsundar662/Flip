import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificaitonScreen extends StatelessWidget {
  const EmailVerificaitonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(VerifyWithEmailEvent());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is EmailVerifiedSuccessState) {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => RootScreen()));
                }
              },
              child: ElevatedButtonWidget(
                  onEvent: () {
                    if (FirebaseAuth.instance.currentUser!.emailVerified) {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => RootScreen()));
                    } else {
                      print('not done');
                    }
                  },
                  buttonTitle: Text('Verify and continue'),
                  style: TextStyle(color: Colors.white),
                  buttonStyles: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue))),
            )
          ],
        ),
      ),
    );
  }
}
