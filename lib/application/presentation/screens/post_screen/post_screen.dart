import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/post/post_bloc.dart';
import 'package:flip/application/presentation/screens/post_screen/post_image_preview.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';


class PostScreen extends StatelessWidget {
  const PostScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final postBlocProvider = context.read<PostBloc>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
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
                    controller: postBlocProvider.textContentController,
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
                  BlocListener<PostBloc, PostState>(
                    listenWhen: (previous, current) =>
                        current is PostImageSelectedState &&
                        previous is PostInitial,
                    listener: (context, state) {
                      if (state is PostImageSelectedState) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => PostImagePreview(
                                  selecedImage: state.selectedImageFile)),
                        );
                      }
                    },
                    child: IconButton(
                        onPressed: () {
                          postBlocProvider.add(PostImageSelectionEvent());
                        },
                        icon: Icon(
                          Icons.photo_library_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  ),
                  const Spacer(),
                  BlocConsumer<PostBloc, PostState>(
                      listenWhen: (pre, curre) =>
                          curre is PostThoughtsAdditionSuccessState,
                      listener: (context, state) {
                        AnimatedSnackBar.material(
                          'success',
                          type: AnimatedSnackBarType.success,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context); 
                       Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RootScreen()),
                          (route) => false);
                      },
                      builder: (context, state) {
                        if (state is PostAdditionLoadingState) {
                          const CircularProgressIndicator();
                        }
                        return IconButton(
                            onPressed: () {
                              final model = PostModel(
                                  username: '',
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  textContent: postBlocProvider
                                      .textContentController.text
                                      .trim(),
                                  imageUrls: [],
                                  timestamp: DateTime.now(),
                                  likes: [],
                                  comments: [],);
                              postBlocProvider
                                  .add(PostThoughtsEvents(model: model,userId: FirebaseAuth.instance.currentUser!.uid));
                            },
                            icon: Icon(
                              Iconsax.send_24,
                              color: Theme.of(context).colorScheme.secondary,
                            ));
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// final imageUrl = await PickImage().uploadImages(path);
                          // final post = PostModel(
                          //     userId: FirebaseAuth.instance.currentUser!.uid,
                          //     textContent: textContentController.text,
                          //     imageUrls: imageUrl,
                          //     timestamp: DateTime.now(),
                          //     likes: [],
                          //     comments: []);
                          // Post().createPost(post);