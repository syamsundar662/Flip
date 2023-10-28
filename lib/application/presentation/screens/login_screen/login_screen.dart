import 'dart:developer';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/forgot_password_sections/forgot_password_step_one/forgot_password_screen_step_one.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/screens/signup_section/username_creation/username_creation_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/validations/snackbars/snackbars.dart';
import 'package:flip/application/presentation/widgets/animations/animated_opactity.dart';
import 'package:flip/application/presentation/widgets/animations/slide_animation.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flip/domain/models/login_in/login_model.dart';
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
    final authBlocProvider = context.read<AuthBloc>();
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
                              fontSize: 58,
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
                        controller: authBlocProvider.emailController,
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
                            HapticFeedback.heavyImpact();
                            return 'Please enter a password';
                          } else {
                            return null;
                          }
                        },
                        filledColor: const Color.fromARGB(50, 158, 158, 158),
                        hintText: 'Enter a password',
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
                      Padding(
                        padding: kPaddingForTextfield,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordScreenStepOne()));
                                },
                                child: const Text(
                                  'Forgot password? ',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                      kHeight10,
                      Padding(
                        padding: kPaddingForTextfield,
                        child: BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              print(state);
                              if (state is AuthSuccessState &&
                                  state.authResponse ==
                                      AuthenticationResults.logInSuccess) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const RootScreen()),
                                    (route) => false);

                                authBlocProvider.passwordController.clear();
                              }
                              if (state is AuthErrorState) {
                                validationSnackbars(
                                    context: context,
                                    authResult: state.authResponse);
                              }
                            },
                            child: ElevatedButtonWidget(
                              onEvent: () async {
                                _formkey.currentState!.validate();
                                if (authBlocProvider
                                        .emailController.text.isNotEmpty ||
                                    authBlocProvider
                                        .passwordController.text.isNotEmpty) {
                                  final response = LogInModel(
                                      email:
                                          authBlocProvider.emailController.text,
                                      password: authBlocProvider
                                          .passwordController.text);
                                  context
                                      .read<AuthBloc>()
                                      .add(LogInEvent(logIn: response));
                                  log('success');
                                } else {
                                  HapticFeedback.heavyImpact();
                                  return Exception('Something went wrong');
                                }
                              },
                              buttonTitle: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
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
                            )),
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
                      listenWhen: (previous, current) =>
                          current is AuthSuccessState,
                      listener: (context, state) {
                        if (state is AuthErrorState) {
                          print(state.authResponse);
                        }
                        state as AuthSuccessState;
                        if (AuthenticationResults.googleSignInSuccess ==
                            state.authResponse) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const RootScreen()),
                              (route) => false);
                        } else if (AuthenticationResults.newUser ==
                            state.authResponse) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => UsernameRegistration()),
                              (route) => false);
                        } else if (AuthenticationResults.googleSignInFailed ==
                            state.authResponse) {
                          print(state.authResponse);
                        }
                      },
                      child: InkWell(
                        onTap: () {
                          context.read<AuthBloc>().add(SignUpWithGoogleEvent());
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
                    kHeight20,
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => UsernameRegistration()),
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
}
