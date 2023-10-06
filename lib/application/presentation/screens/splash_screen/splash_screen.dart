import 'package:flip/application/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    size(context);
    
    return Scaffold(
      body: Container(
        height: screenFullHeight,
        width: screenFullWidth,
        decoration: const BoxDecoration(
          gradient: mainGradient
        ),
        child: Align(
          child: InkWell(
            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context)=>SignUpScreen())),
            child: Text(
            'Flip',
            style: GoogleFonts.baloo2(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          ),),
      ),
    );
  }
}