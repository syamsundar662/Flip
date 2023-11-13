import 'package:flip/application/presentation/screens/signup_section/email_validation/email_validation_screen.dart';
import 'package:flip/application/presentation/widgets/animations/animated_opactity.dart';
import 'package:flip/application/presentation/widgets/animations/slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordConfirmationScreen extends StatefulWidget {
  const PasswordConfirmationScreen({
    super.key,
    this.userName,
  });
  final String? userName;
  @override
  PasswordConfirmationScreenState createState() =>
      PasswordConfirmationScreenState();
}

class PasswordConfirmationScreenState
    extends State<PasswordConfirmationScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isVisible = false;
  bool obscureTxt = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {
          isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBlocProvider = context.read<AuthBloc>();
    return Scaffold(
      body: Container(
        height: screenFullHeight,
        width: double.infinity,
        decoration: const BoxDecoration(gradient: mainGradient),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedOpacityWidget(
                isVisible: isVisible,
                animatedOpacityWidgetVariable: SlideAnimationWidget(
                  slideAnimationWidgetVariable: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: kPaddingForTextfield,
                        child: Text(
                          'Create passowrd',
                          style: GoogleFonts.baloo2(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: kPaddingForTextfield,
                        child: Text(
                          'Create a password with atlest 6 charaters or numbers',
                          style: GoogleFonts.baloo2(fontSize: 15),
                        ),
                      ),
                      kHeight10,
                      TextFormFields(
                        padding: kPaddingForTextfield,
                        prefixIcons: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        obscure: obscureTxt,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a password';
                          } else {
                            return null;
                          }
                        },
                        filledColor: const Color.fromARGB(50, 158, 158, 158),
                        hintText: 'Create new password',
                        controller: authBlocProvider.passwordController,
                        suffixIconWidget: obscureTxt
                            ? IconButton(
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    obscureTxt = false;
                                  });
                                },
                                icon: const Icon(Icons.visibility_off_outlined),
                                color: const Color.fromARGB(102, 255, 255, 255))
                            : IconButton(
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    obscureTxt = true;
                                  });
                                },
                                icon: const Icon(
                                  Icons.visibility_outlined,
                                ),
                                color:
                                    const Color.fromARGB(102, 255, 255, 255)),
                      ),
                      kHeight10,
                      TextFormFields(
                        padding: kPaddingForTextfield,
                        prefixIcons: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        obscure: obscureTxt,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a password';
                          } else {
                            return null;
                          }
                        },
                        filledColor: const Color.fromARGB(50, 158, 158, 158),
                        hintText: 'Confirm password',
                        controller: authBlocProvider.confirmPasswordController,
                      ),
                    ],
                  ),
                ),
              ),
              kHeight10,
              Padding(
                  padding: kPaddingForTextfield,
                  child: ElevatedButtonWidget(
                    height: screenFullHeight * .07,
                    width: screenFullWidth,
                    onEvent: () async {
                      if (!_formkey.currentState!.validate()) return;
                      if (authBlocProvider.passwordController.text.length < 6) {
                        // HapticFeedback.heavyImpact();
                        AnimatedSnackBar.material(
                          'Weak password',
                          type: AnimatedSnackBarType.error,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      } else if (authBlocProvider.passwordController.text !=
                          authBlocProvider.confirmPasswordController.text) {
                        AnimatedSnackBar.material(
                          'Confirm password does not match',
                          type: AnimatedSnackBarType.error,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      } else {
                        // final confirmPassword = authBlocProvider.confirmPasswordController.text;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailValidationScreen()));
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
                  )),
              kHeight40,
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                },
                child: const Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
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
