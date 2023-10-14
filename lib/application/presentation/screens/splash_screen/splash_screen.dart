import 'package:flip/application/presentation/screens/get_started_screen/get_started.dart';
import 'package:flip/application/presentation/screens/home_screen/home.dart';
import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
   const SplashScreen({super.key});

 
  // check(context) async{
  //   if(hasData) { 

  //     await Future.delayed(const Duration(seconds: 4));
  //     Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>HomePage()), (route) => false);
  //   }else{

  //     await Future.delayed(const Duration(seconds: 4));
  //     Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>LoginScreen()), (route) => false);

  //   }
  // } 

  

  @override
  Widget build(BuildContext context) {
    size(context);
    // check(context);
    
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