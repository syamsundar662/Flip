import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  const TextFormFields({
    super.key, required this.hintText, required this.filledColor, this.suffixIconWidget, this.controller, this.validator,  required this.obscure, this.prefixIcons,
  });
  final String hintText;
  final Color filledColor;
  final Widget? suffixIconWidget; 
  final Widget? prefixIcons; 
  final bool obscure;
  final TextEditingController ? controller;
  final String? Function(String?) ? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPaddingForTextfield, 
      child: SizedBox(
        // height: screenFullHeight*.08,55
        child: TextFormField( 
          validator: validator,
          controller: controller,
          style: const TextStyle(color: Colors.grey),
          obscureText: obscure,
          decoration: InputDecoration(
            fillColor: filledColor ,
            filled: true,
            hintStyle: const TextStyle(color: Color.fromARGB(147, 255, 255, 255,),fontWeight: FontWeight.w300,fontSize: 15 ),
            hintText: hintText,
            suffixIcon:suffixIconWidget ,
            prefixIcon : prefixIcons,
            border: OutlineInputBorder( 
              borderRadius:BorderRadius.circular(15)
            )
            
          ),
        ),
      ),
    );
  }
}