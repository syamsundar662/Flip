import 'package:flip/application/presentation/utils/constants/constants.dart';
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
          child: Text(
          'Flip', 
          style: GoogleFonts.baloo2(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ), 
          ),),
      ),
    );
  }
}