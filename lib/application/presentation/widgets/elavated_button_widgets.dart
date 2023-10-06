
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenFullHeight*.06,
      width: screenFullWidth,
      child: ElevatedButton(onPressed: (){}, child: Text('Sign Up',style: TextStyle(color: Colors.white),),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 54, 114, 226)),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
      ),),
    );
  }
}
