import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key, required this.buttonTitle, required this.style, required this.buttonStyles, this.onEvent, required this.height, required this.width,
  });
  final Widget buttonTitle;
  final TextStyle style;
  final ButtonStyle buttonStyles;
  final Function() ? onEvent;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(onPressed: onEvent,
      style: buttonStyles, child: buttonTitle),
    );
  }
}
 