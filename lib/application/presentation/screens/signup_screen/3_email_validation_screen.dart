import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/signup_screen/4_sign_in_email_verification.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flip/domain/models/sign_up/sign_up_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpWithEmail extends StatelessWidget {
  SignUpWithEmail({super.key, required this.createdPassword});
  final _formkey = GlobalKey<FormState>();
  final String createdPassword;
  @override
  Widget build(BuildContext context) {
    final authBlocProvider = context.read<AuthBloc>();
    authBlocProvider.add(VerifyWithEmailEvent());
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: mainGradient,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: kPaddingForTextfield,
              child: Text(
                'Enter your email address!',
                style: GoogleFonts.baloo2(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: kPaddingForTextfield,
              child: Text(
                'Enter the valid email address to sign up and varify',
                style: GoogleFonts.baloo2(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            kHeight10,
            TextFormFields(
              prefixIcons: const Icon(
                Icons.mail,
                color: Colors.grey,
              ),
              obscure: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a valid gmail';
                } else {
                  return null;
                }
              },
              filledColor: const Color.fromARGB(50, 158, 158, 158),
              hintText: 'Enter your gmail',
              controller: authBlocProvider.emailController,
            ),
            kHeight10,
            Padding(
                padding: kPaddingForTextfield,
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccessState &&
                        state.authResponse ==
                            AuthenticationResults.signUpSuccess) {
                      Navigator.push(
                          context,  
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const EmailVerificaitonScreen()));
                    }
                    if (state is AuthErrorState) {
                      if (state.authResponse ==
                          AuthenticationResults.alreadyRegisteredEmail) {
                        AnimatedSnackBar.material(
                          state.authResponse.name,
                          type: AnimatedSnackBarType.error,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      } else if (state.authResponse ==
                          AuthenticationResults.invalidEmail) {
                        AnimatedSnackBar.material(
                          state.authResponse.name,
                          type: AnimatedSnackBarType.error,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      } else if (state.authResponse ==
                          AuthenticationResults.somethingWentWrong) {
                        AnimatedSnackBar.material(
                          state.authResponse.name,
                          type: AnimatedSnackBarType.error,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      } else if (state.authResponse ==
                          AuthenticationResults.errorOccurs) {
                        AnimatedSnackBar.material(
                          state.authResponse.name,
                          type: AnimatedSnackBarType.error,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return ElevatedButtonWidget(
                      onEvent: () async {
                        _formkey.currentState!.validate();
                        if (authBlocProvider.emailController.text.isNotEmpty ||
                            createdPassword.isNotEmpty) {
                          final signUp = SignUpModel(
                              email: authBlocProvider.emailController.text,
                              password: createdPassword);
                          authBlocProvider.add(SignUpEvent(signUp: signUp));
                        }
                      },
                      buttonTitle: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      buttonStyles: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 41, 87, 195)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                      ),
                    );
                  },
                )),
            kHeight50,
          ]),
        ),
      ),
    );
  }
}