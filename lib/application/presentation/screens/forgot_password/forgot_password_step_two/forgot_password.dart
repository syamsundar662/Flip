import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreenStepTwo extends StatelessWidget {
  const ForgotPasswordScreenStepTwo(
      {super.key, required this.emailFromController});
  final String emailFromController;

  @override
  Widget build(BuildContext context) {
    final authBlocProvider = context.read<AuthBloc>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: mainGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reset password',
                style: GoogleFonts.baloo2(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              kHeight10,
              Image.asset(
                'assets/reset-password.png',
                scale: 3,
              ),
              Padding(
                  padding: kPaddingForTextfield,
                  child: Text(
                      'Please click on the button below to receive a password reset link in your email.',
                      style: GoogleFonts.baloo2(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      textAlign: TextAlign.center)),
              kHeight10,
              BlocConsumer<AuthBloc, AuthState>(
                listenWhen: (previous, current) =>
                    current is PasswordResetSuccessState,
                buildWhen: (previous, current) =>
                    current is! PasswordResetSuccessState,
                listener: (context, state) {
                  state as PasswordResetSuccessState;
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      backgroundColor: Color.fromARGB(57, 255, 255, 255),
                      content: Text(
                        'Reset link sent successfully',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  return Padding(
                    padding: kPaddingForTextfield,
                    child: ElevatedButtonWidget(
                        height: screenFullHeight * .07,
                        width: screenFullWidth,
                        onEvent: () async {
                          if (emailFromController.isNotEmpty) {
                            context.read<AuthBloc>().add(
                                PasswordResetEvent(email: emailFromController));
                            await Future.delayed(const Duration(seconds: 4));
                            authBlocProvider.passwordResetController.clear();
                          } else {
                            AnimatedSnackBar.material('Something went wrong',
                                    type: AnimatedSnackBarType.error)
                                .show(context);
                          }
                        },
                        buttonStyles: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            backgroundColor: const MaterialStatePropertyAll(
                              Color.fromARGB(255, 41, 87, 195),
                            )),
                        buttonTitle: const Text(
                          'Reset password',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white)),
                  );
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        (MaterialPageRoute(
                            builder: (context) => const LoginScreen())),
                        (route) => false);
                  },
                  child: const Text('Back to Login'))
            ],
          ),
        ),
      ),
    );
  }
}
