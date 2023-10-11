import 'package:flip/application/presentation/screens/home_screen/home.dart';
import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/screens/signup_screen/widgets/animations.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenFullHeight,
          width: screenFullWidth,
          decoration: const BoxDecoration(gradient: mainGradient),
          child: Column(
            children: [
              SizedBox(
                height: screenFullHeight / 2,
                width: screenFullWidth,
                // child: FlipAlignAnimation(
                //   animationWidget: Text(
                //     'Flip',
                //     style: GoogleFonts.baloo2(
                //         fontSize: 60,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white),
                //   ),
                // )
                child: Align(
                  child: Text(
                    'Flip',
                    style: GoogleFonts.baloo2(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const TextFormFields(
                filledColor: Color.fromARGB(50, 158, 158, 158),
                hintText: 'Enter your gmail',
              ),
              kHeight10,
              const TextFormFields(
                filledColor: Color.fromARGB(50, 158, 158, 158),
                hintText: 'Enter a password',
                suffixIconWodget: Icon(
                  Icons.visibility_off_outlined,
                  color: Color.fromARGB(102, 255, 255, 255),
                ),
              ),
              kHeight10,
              Padding(
                padding: kPaddingForTextfield,
                child: ElevatedButtonWidget(
                  onEvent: () => Navigator.push(context,
                      (MaterialPageRoute(builder: (context) => const LoginScreen()))),
                  buttonTitle: 'SignUp',
                  style: const TextStyle(color: Colors.white),
                  buttonStyles: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 41, 87, 195)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                ),
              ),
              kHeight40,
              kHeight20,
              const Text(
                'Or',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              kHeight40,
              kHeight10,
              Padding(
                padding: kPaddingForTextfield,
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
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      )),
                ),
              ),
              kHeight10,
              const Text(
                'Alreday have an account? Login.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
