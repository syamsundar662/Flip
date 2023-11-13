import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/screens/signup_section/username_creation/username_creation_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/flip_logo/flip_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

bool selected = true;

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: mainGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: kPaddingForTextfield,
                  child: Column(
                    children: [
                      const FlipLogoText(logoSize: 50),
                      ElevatedButtonWidget(
                        height: screenFullHeight * .07,
                        width: screenFullWidth,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        buttonStyles: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                              Color.fromARGB(255, 255, 255, 255)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        onEvent: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => UsernameRegistration(),
                            ),
                          );
                        },
                        buttonTitle: Text(
                          'Create an account',
                          style: GoogleFonts.baloo2(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                      kHeight10,
                      ElevatedButtonWidget(
                        height: screenFullHeight * .07,
                        width: screenFullWidth,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        buttonStyles: ButtonStyle(
                          side: const MaterialStatePropertyAll(
                              BorderSide(width: .7, color: Colors.white)),
                          backgroundColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        onEvent: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                          setState(() {
                            selected = false;
                          });
                        },
                        buttonTitle: Text(
                          'Login',
                          style: GoogleFonts.baloo2(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                      kHeight60
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
