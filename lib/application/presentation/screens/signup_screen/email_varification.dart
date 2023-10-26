import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flip/application/business_logic/bloc/auth/auth_bloc.dart';
import 'package:flip/application/presentation/screens/home_screen/home_screen.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpWithEmail extends StatelessWidget {
  SignUpWithEmail({super.key, required this.createdPassword});
  final _formkey = GlobalKey<FormState>();
  final String createdPassword ;
  @override
  Widget build(BuildContext context) {
    final authBlocProvider = context.read<AuthBloc>();
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
                    if (state.returnValue == 'success') {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const RootScreen ()),
                          (route) => false);
                    } else if (state.returnValue ==
                        'Email already registered') {
                      AnimatedSnackBar.material(
                        state.returnValue,
                        type: AnimatedSnackBarType.error,
                        mobileSnackBarPosition: MobileSnackBarPosition.top,
                      ).show(context);
                    } else if (state.returnValue == 'Sign up failed') {
                      AnimatedSnackBar.material(
                        state.returnValue,
                        type: AnimatedSnackBarType.error,
                        mobileSnackBarPosition: MobileSnackBarPosition.top,
                      ).show(context);
                    } else if (state.returnValue == 'Invalid email') {
                      AnimatedSnackBar.material(
                        state.returnValue,
                        type: AnimatedSnackBarType.error,
                        mobileSnackBarPosition: MobileSnackBarPosition.top,
                      ).show(context);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButtonWidget(
                      onEvent: () async {
                        _formkey.currentState!.validate();
                        print('nooo');
                        if (authBlocProvider.emailController.text.isNotEmpty ||
                                createdPassword.isNotEmpty) {
                          authBlocProvider.add(SignUpEvent( 
                              authBlocProvider.emailController.text,
                              createdPassword));
                        }
                      },
                      buttonTitle
                          // ? const CupertinoActivityIndicator(
                          //     color: Colors.white, 
                          //   )
                          : const Text(
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
            kHeight50
          ]),
        ),
      ),
    );
  }
}

// else if (state.returnValue ==
//                           'Email already registered') {
//                         AnimatedSnackBar.material(
//                           state.returnValue,
//                           type: AnimatedSnackBarType.error,
//                           mobileSnackBarPosition: MobileSnackBarPosition.top,
//                         ).show(context);
//                       } 
// else if (state.returnValue == 'Sign up failed') {
//                         AnimatedSnackBar.material(
//                           state.returnValue,
//                           type: AnimatedSnackBarType.error,
//                           mobileSnackBarPosition: MobileSnackBarPosition.top,
//                         ).show(context);
//                       } else if (state.returnValue == 'Invalid email') {
//                         AnimatedSnackBar.material(
//                           state.returnValue,
//                           type: AnimatedSnackBarType.error,
//                           mobileSnackBarPosition: MobileSnackBarPosition.top,
//                         ).show(context);
//                       }

// else if (emailController.text.isNotEmpty ||
//                             passwordController.text.isNotEmpty ||
//                             confirmPasswordController.text.isNotEmpty) {
//                           context.read<AuthBloc>().add(SignUpEvent(
//                               emailController.text.trim(),
//                               passwordController.text.trim()));
//                         } 