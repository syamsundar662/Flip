import 'package:flip/application/presentation/screens/signup_screen/widgets/animations.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
          children: [ 
            SizedBox(
          height: screenFullHeight/2,
          width: screenFullWidth ,
          child: const FlipAlignAnimation()),
          const TextFormFields(hintText: 'Enter your gmail',), 
          kHeight10, 
          const TextFormFields(hintText: 'Enter a password',),
          kHeight10,
          const Padding(
            padding: kPaddingForTextfield,
            child: ElevatedButtonWidget(),
          )
          ],          
        ),
      ),
    );
  }
}


