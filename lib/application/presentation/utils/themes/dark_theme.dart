
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark, 
  primaryColor: Colors.grey[900]!, 
  colorScheme: const ColorScheme.dark().copyWith(background: Colors.black),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: Colors.lightBlue,unselectedItemColor: Colors.white38 )

);  