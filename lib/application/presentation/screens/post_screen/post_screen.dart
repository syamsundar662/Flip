import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight20,
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text('Share your thoughts',
                    style: GoogleFonts.balooDa2(
                        fontSize: 23, fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                  height: screenFullHeight / 5,
                  child: TextField(
                    maxLines: 10,
                    // controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: 'type here....',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Theme.of(context).colorScheme.primary,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        )),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  )),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.photo_camera_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.photo_library_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Iconsax.send_24,
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
