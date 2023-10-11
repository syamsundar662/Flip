import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  const TextFormFields({
    super.key, required this.hintText, required this.filledColor, this.suffixIconWodget,
  });
  final String hintText;
  final Color filledColor;
  final Widget? suffixIconWodget; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPaddingForTextfield, 
      child: SizedBox(
        height: 55,
        child: TextFormField( 
          
          decoration: InputDecoration(
            fillColor: filledColor ,
            filled: true,
            hintStyle: TextStyle(color: Color.fromARGB(147, 255, 255, 255,),fontWeight: FontWeight.w300,fontSize: 15 ),
            hintText: hintText,
            suffixIcon:suffixIconWodget ,
            border: OutlineInputBorder(
              
              borderSide: BorderSide.none ,
              
              borderRadius:BorderRadius.circular(15)
            )
            
          ),
        ),
      ),
    );
  }
}