import 'package:flip/application/presentation/screens/home_screen/home.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenFullHeight,
        width: screenFullWidth,
        decoration: const BoxDecoration(
          gradient: mainGradient 
          
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
             filledColor: Color.fromARGB(30, 158, 158, 158),
            hintText: 'Enter your gmail',), 
          kHeight10, 
          const TextFormFields( 
             filledColor: Color.fromARGB(30, 158, 158, 158),
            hintText: 'Enter a password',),
          kHeight10,
           Padding(
            padding: kPaddingForTextfield,
            child:  ElevatedButtonWidget(
                  onEvent: () => Navigator.push(context,
                      (MaterialPageRoute(builder: (context) =>  HomePage()))),
                  buttonTitle: 'Login',
                  style: const TextStyle(color: Colors.white),
                  buttonStyles: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 41, 87, 195)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                ),
          ),

          ],          
        ),
      ),
    );
  }
}