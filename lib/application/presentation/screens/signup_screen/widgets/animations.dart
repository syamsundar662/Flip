import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlipAlignAnimation extends StatefulWidget {
  const FlipAlignAnimation({super.key});

  @override
  State<FlipAlignAnimation> createState() => _FlipAlignAnimationState();
}

class _FlipAlignAnimationState extends State<FlipAlignAnimation> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selected = !selected;
      }),
      child: AnimatedAlign(
        alignment: selected ? Alignment.topCenter : Alignment.bottomCenter,
        duration: const Duration(milliseconds: 3000),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Text(
          'Flip',
          style: GoogleFonts.baloo2(
              fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
