import 'package:flutter/material.dart';

class DarkThemeClass {
  ThemeData darkTheme = ThemeData(
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white)),
      ),
      brightness: Brightness.dark,
      primaryColor: Colors.grey[900]!,
      colorScheme: const ColorScheme.dark().copyWith(
          background: Colors.black, //Main screen background color
          primary: const Color.fromARGB(255, 41, 41, 41),
          secondary: Colors.grey,
          onTertiary: const Color.fromARGB(255, 41, 41, 41),
          onPrimary: Colors.white),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, surfaceTintColor: Colors.transparent),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.white38));
}  
