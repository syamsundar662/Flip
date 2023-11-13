import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/forgot_password_sections/forgot_password_step_two/forgot_password.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreenStepOne extends StatelessWidget {
  const ForgotPasswordScreenStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final authBlocProvider = context.read<AuthBloc>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: mainGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: kPaddingForTextfield,
                  child: Text(
                    'Forgot password?',
                    style: GoogleFonts.baloo2(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                  padding: kPaddingForTextfield,
                  child: Text(
                    'Please enter your email address to begin with password reset process',
                    style: GoogleFonts.baloo2(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              kHeight10,
              TextFormFields(
                padding: kPaddingForTextfield,
                hintText: 'Email',
                filledColor: const Color.fromARGB(50, 158, 158, 158),
                obscure: false,
                controller: authBlocProvider.passwordResetController,
              ),
              kHeight10,
              Padding(
                padding: kPaddingForTextfield,
                child: ElevatedButtonWidget(
                    height: screenFullHeight * .07,
                    width: screenFullWidth,
                    onEvent: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ForgotPasswordScreenStepTwo(
                                    emailFromController: authBlocProvider
                                        .passwordResetController.text,
                                  )));
                    },
                    buttonTitle: const Text(
                      'Continue to reset',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(),
                    buttonStyles: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 41, 87, 195)))),
              ),
              kHeight60
            ],
          ),
        ),
      ),
    );
  }
}
