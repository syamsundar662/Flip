import 'dart:developer';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/home_screen/home_shimmer.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flip/application/presentation/screens/signup_screen/username.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/animations/animated_opactity.dart';
import 'package:flip/application/presentation/widgets/animations/slide_animation.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    size(context);
    return Scaffold(
      body: Container(
        height: screenFullHeight,
        width: screenFullWidth,
        decoration: const BoxDecoration(gradient: mainGradient),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: AnimatedOpacityWidget(
                    isVisible: isVisible,
                    animatedOpacityWidgetVariable: Align(
                      child: SlideAnimationWidget(
                        slideAnimationWidgetVariable: Text(
                          'Flip',
                          style: GoogleFonts.baloo2(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )),
              ),




              AnimatedOpacityWidget(
                isVisible: isVisible,
                animatedOpacityWidgetVariable: SlideAnimationWidget(
                  slideAnimationWidgetVariable: Column(
                    children: [
                      TextFormFields(
                        prefixIcons: const Icon(
                          Icons.email_rounded,
                          color: Colors.grey,
                        ),
                        obscure: false,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            HapticFeedback.heavyImpact();
                            return 'Please enter your email';
                          } else {
                            return null;
                          }
                        },
                        filledColor: const Color.fromARGB(50, 158, 158, 158),
                        hintText: 'Enter your gmail',
                      ),
                      kHeight10,
                      TextFormFields(
                        prefixIcons: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        obscure: obscureTxt,
                        validator: (value) {
                          if (value!.isEmpty) {
                            HapticFeedback.heavyImpact ();
                            return 'Please enter a password';
                          } else {
                            return null;
                          }
                        },
                        filledColor: const Color.fromARGB(50, 158, 158, 158),
                        hintText: 'Enter a password',
                        controller: passwordController,
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
                      Padding(
                        padding: kPaddingForTextfield,
                        child: BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state.returnValue == 'log in success') {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => const RootScreen()),
                                  (route) => false);
                              emailController.clear();
                              passwordController.clear();
                            } else if (state.returnValue == 'invalid email') {
                              HapticFeedback.heavyImpact();
                              animatedSnackbar(
                                      state, AnimatedSnackBarType.error)
                                  .show(context);
                            } else if (state.returnValue == 'wrong password') {
                              HapticFeedback.heavyImpact();
                              animatedSnackbar(
                                      state, AnimatedSnackBarType.error)
                                  .show(context);
                            } else if (state.returnValue == 'user not found') {
                             
                              HapticFeedback.heavyImpact();
                              animatedSnackbar(
                                      state, AnimatedSnackBarType.error)
                                  .show(context);
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButtonWidget(
                              onEvent: () async {
                                _formkey.currentState!.validate();
                                if (emailController.text.isNotEmpty ||
                                    passwordController.text.isNotEmpty) {
                                  context.read<AuthBloc>().add(SignInEvent(
                                      emailController.text.trim(),
                                      passwordController.text.trim()));
                                } else {
                                    //  HapticFeedback.heavyImpact();  
                                  return Exception('Something went wrong');
                                }
                              },
                              buttonTitle: state.isSaving
                                  ? const CupertinoActivityIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                              style: const TextStyle(color: Colors.white),
                              buttonStyles: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Color.fromARGB(255, 41, 87, 195)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)))),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kHeight10,
              Padding(
                    padding: kPaddingForTextfield,
                    child: Column(
                      children: [
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state.returnValue == 'google signin success') {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            } else {
                              log(state.returnValue);
                            }
                          },
                          child: InkWell(
                            onTap: () {
                              context.read<AuthBloc>().add(SignUpWithGoogle());
                            },
                            child: Container(
                              height: screenFullHeight * .07,
                              width: screenFullWidth,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  image: const DecorationImage(
                                      alignment: Alignment(-0.65, 0.0),
                                      image: AssetImage(
                                        'assets/Google__G__Logo 1 (1).png',
                                      ),
                                      scale: 15)),
                              child: const Align(
                                alignment: Alignment(0.2, 0.0),
                                child: Text(
                                  'Sign in using google',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        kHeight30,
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        UsernameRegistration()),
                                (route) => false);
                          },
                          child: const Text(
                  'Dont have an account? Create',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                        ),
                      ],
                    ),
                  ),


              kHeight30, 
            ],
          ),
        ),
      ),
    );
  }

  AnimatedSnackBar animatedSnackbar(
      AuthState state, AnimatedSnackBarType type) {
    return AnimatedSnackBar.material(
      state.returnValue,
      type: type,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    );
  }
}
