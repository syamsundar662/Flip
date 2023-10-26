
import 'package:flutter/material.dart';
class DarkThemeClass{

  ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark, 
  primaryColor: Colors.grey[900]!, 
  colorScheme: const ColorScheme.dark().copyWith(background: Colors.black,primary: const Color.fromARGB(255, 41, 41, 41),secondary: Colors.grey ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black,),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: Colors.lightBlue,unselectedItemColor: Colors.white38 )

);  
} 