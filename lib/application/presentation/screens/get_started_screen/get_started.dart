import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flip/application/presentation/screens/signup_screen/widgets/animations.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
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
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient),
        child: Column(
          children: [
            SizedBox(
              height: screenFullHeight/2,
              width: double.infinity,
              child: selected? ElevatedButtonWidget(
                onEvent: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  setState(() {
                    selected = false;
                  });
                },
                buttonTitle: 'Get Started',style: const TextStyle(),buttonStyles: const ButtonStyle(),):Container()
            ),
            SizedBox(
                height: screenFullHeight / 3,
                width: screenFullWidth,
                child:  FlipAlignAnimation(animationWidget: Text(
          'Flip', 
          style: GoogleFonts.baloo2(
              fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
        ),)),
          ],
        ), 
      ),
    );
  }
}