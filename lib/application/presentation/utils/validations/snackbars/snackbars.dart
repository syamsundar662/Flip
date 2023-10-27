 import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';

void validationSnackbars({required BuildContext context ,required AuthenticationResults authResult}){
                          if(authResult == AuthenticationResults.invalidEmail){  
                            AnimatedSnackBar.material('Invalid email adrress', type: AnimatedSnackBarType.error).show(context);
                          }
                          else if(authResult == AuthenticationResults.wrongPassword){
                            AnimatedSnackBar.material('Wrong password', type: AnimatedSnackBarType.error).show(context);
                          }
                          else if(authResult == AuthenticationResults.userNotFound){
                            AnimatedSnackBar.material('User not found', type: AnimatedSnackBarType.error).show(context);
                          }} 