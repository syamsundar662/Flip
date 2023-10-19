import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key, required this.buttonTitle, required this.style, required this.buttonStyles, this.onEvent,
  });
  final Widget buttonTitle;
  final TextStyle style;
  final ButtonStyle buttonStyles;
  final Function() ? onEvent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenFullHeight*.06 ,
      width: screenFullWidth,
      child: ElevatedButton(onPressed: onEvent,
      style: buttonStyles, child: buttonTitle),
    );
  }
}
 