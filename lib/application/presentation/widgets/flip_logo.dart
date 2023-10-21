import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlipLogoText extends StatelessWidget {
  const FlipLogoText({
    super.key,
    required this.logoSize,
  });
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Flip',
      style: GoogleFonts.baloo2(
        fontSize: logoSize,
        fontWeight: FontWeight.bold,
        // color:logoColor
      ),
    );
  }
}
