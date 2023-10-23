import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/data/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: IconButton(onPressed: (){
          AuthRepository().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
        }, icon: Icon(Icons.logout)),

      ),
    );
  }
} 