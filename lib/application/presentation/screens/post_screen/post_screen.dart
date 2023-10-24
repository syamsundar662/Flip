import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  height: screenFullHeight / 5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 71, 71, 71).withOpacity(.7),
                      border: Border.all(color: const Color.fromARGB(255, 45, 45, 45).withOpacity(.3)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Share your thoughts!',
                            style: GoogleFonts.baloo2(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        Text('type here....',
                            style: GoogleFonts.baloo2(
                                fontSize: 17, fontWeight: FontWeight.w500,color: Colors.grey.withOpacity(.7))),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
