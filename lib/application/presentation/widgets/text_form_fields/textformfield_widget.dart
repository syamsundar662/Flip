import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  const TextFormFields({
    super.key, required this.hintText, required this.filledColor, this.suffixIconWidget, this.controller, this.validator,  required this.obscure, this.prefixIcons, required this.padding,
  });
  final String hintText;
  final Color filledColor;
  final Widget? suffixIconWidget; 
  final Widget? prefixIcons; 
  final bool obscure;
  final TextEditingController ? controller;
  final String? Function(String?) ? validator;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding, 
      child: SizedBox(
        child: TextFormField( 
          validator: validator, 
          controller: controller,
          style: const TextStyle(color: Colors.grey),
          obscureText: obscure,
          cursorColor: const Color.fromARGB(255, 95, 95, 95) ,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Color.fromARGB(255, 191, 191, 191),width: .2 ),),
            fillColor: filledColor ,
            filled: true, 
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(15)),
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