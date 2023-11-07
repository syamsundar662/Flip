import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/image/image_picker.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  List<File> path = [];
  final TextEditingController textContentController = TextEditingController();

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
                        controller: textContentController,
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
                          onPressed: () {
                            path.clear();
                          },
                          icon: Icon(
                            Icons.photo_camera_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                      IconButton(
                          onPressed: () async {
                            final imagePath =
                                await PickImage().multiImagePicker();

                            path = imagePath;
                          },
                          icon: Icon(
                            Icons.photo_library_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                      const Spacer(),
                      IconButton(
                          onPressed: () async {
                            final imageUrl =
                                await PickImage().uploadImages(path);
                            final post = PostModel(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                textContent: textContentController.text,
                                imageUrls: imageUrl,
                                timestamp: DateTime.now(),
                                likes: [],
                                comments: []);
                            Post().createPost(post);
                          },
                          icon: Icon(
                            Iconsax.send_24,
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                    ],
                  ),
                ],
              )
          ),
        ),
      );
  }
}
