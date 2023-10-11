import 'package:flip/application/presentation/screens/get_started_screen/get_started.dart';
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
            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context)=>GetStartedScreen())),
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