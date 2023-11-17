import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/firebase/auth_data_resourse/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificaitonScreen extends StatelessWidget {
  const EmailVerificaitonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(VerifyWithEmailEvent());
    return Scaffold(
      body: PopScope(
        onPopInvoked: (value) async {
          AuthServices().deleteUserFromFirebase();
        },
        child: Container(
          decoration: const BoxDecoration(gradient: mainGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'A verification Email have been sent to your email account',
                style: GoogleFonts.baloo2(
                    fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              kHeight10,
              Image.asset(
                'assets/Daco_566588.png',
                scale: 4,
              ),
              kHeight10,
              Text(
                  'Please click on the link that has been sent to your email account to verify your email and continue sign in.',
                  style: GoogleFonts.baloo2(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
              kHeight100,
              const CupertinoActivityIndicator(),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is EmailVerifiedSuccessState) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const RootScreen()));
                  }
                }, 
                child: TextButton(
                  child: const Text('Please wait'),
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser!.emailVerified) {
                      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>RootScreen()), (route) => false);
                    }
                  },
                ),
              ),
              kHeight60
            ],
          ),
        ),
      ),
    );
  }
}
