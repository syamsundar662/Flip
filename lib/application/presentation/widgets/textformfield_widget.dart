import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  const TextFormFields({
    super.key, required this.hintText,
  });
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPaddingForTextfield, 
      child: SizedBox(
        height: 55,
        child: TextFormField(
          
          decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 255, 255, 255) ,
            filled: true,
            hintText: hintText,
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