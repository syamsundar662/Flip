import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/home_screen/home_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController gmailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenFullHeight,
          width: screenFullWidth,
          decoration: const BoxDecoration(gradient: mainGradient),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: screenFullHeight / 2.6 ,
                  width: screenFullWidth,
                  child: AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    child: Align(
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            curve: Curves.easeInOut,
                            parent: ModalRoute.of(context)?.animation ??
                                AnimationController(vsync: ScaffoldState()),
                          ),
                        ),
                        child: Text(
                          'Flip',
                          style: GoogleFonts.baloo2(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 700),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        curve: Curves.easeInOut,
                        parent: ModalRoute.of(context)?.animation ??
                            AnimationController(vsync: ScaffoldState()),
                      ),
                    ),
                    child: TextFormFields(
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
                      controller: gmailController,
                    ),
                  ),
                ),
                kHeight10,
                AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 700),
                  child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          curve: Curves.easeInOut,
                          parent: ModalRoute.of(context)?.animation ??
                              AnimationController(vsync: ScaffoldState()),
                        ),
                      ),
                      child: TextFormFields(
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
                      )),
                ),
                kHeight10,
                AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 700),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        curve: Curves.easeInOut,
                        parent: ModalRoute.of(context)?.animation ??
                            AnimationController(vsync: ScaffoldState()),
                      ),
                    ),
                    child: Padding(
                      padding: kPaddingForTextfield,
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state.isLogin == false) {
                            if (state.returnValue == 'success') {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                              gmailController.clear();
                              passwordController.clear();
                            } else if (state.returnValue == 'Weak password') {
                              HapticFeedback.heavyImpact(); 
                              AnimatedSnackBar.material(
                                state.returnValue,
                                type: AnimatedSnackBarType.error,
                                mobileSnackBarPosition: 
                                    MobileSnackBarPosition.top,
                              ).show(context);
                            } else if (state.returnValue ==
                                'Email already registered') {
                              AnimatedSnackBar.material(
                                state.returnValue,
                                type: AnimatedSnackBarType.error,
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.top,
                              ).show(context);
                            } else if (state.returnValue == 'Sign up failed') {
                              AnimatedSnackBar.material(
                                state.returnValue,
                                type: AnimatedSnackBarType.error,
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.top,
                              ).show(context);
                            } else if (state.returnValue == 'Invalid email') {
                              AnimatedSnackBar.material(
                                state.returnValue,
                                type: AnimatedSnackBarType.error,
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.top,
                              ).show(context);
                            }
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButtonWidget(
                            onEvent: () async {
                              _formkey.currentState!.validate();
                              if (gmailController.text.isNotEmpty ||
                                  passwordController.text.isNotEmpty) {
                                context.read<AuthBloc>().add(SignUpEvent(
                                    gmailController.text.trim(),
                                    passwordController.text.trim()));
                              } else {
                                return Exception('error');
                              }
                            },
                            buttonTitle: state.isSaving
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  ),
                            style: const TextStyle(color: Colors.white),
                            buttonStyles: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 41, 87, 195)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                kHeight50, 
                const Text(
                  'Or',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                kHeight50,
                AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        curve: Curves.easeInOut,
                        parent: ModalRoute.of(context)?.animation ??
                            AnimationController(vsync: ScaffoldState()),
                      ),
                    ),
                    child: Padding(
                      padding: kPaddingForTextfield,
                      child: Column(
                        children: [
                          BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if(state.returnValue == 'google signin success'){
                                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>HomePage()), (route) => false); 
                              }else{
                                log(state.returnValue);
                              } 
                            }, 
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<AuthBloc>()
                                    .add(SignUpWithGoogle());
                              },
                              child: Container(
                                height: screenFullHeight * .06,
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
                          kHeight10,
                          kHeight10,
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
                              gmailController.clear();
                              passwordController.clear();
                            },
                            child: const Text(
                              'Already have an account?',
                              style: 
                                  TextStyle(fontSize: 14, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
