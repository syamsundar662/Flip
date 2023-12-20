import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/post/post_bloc.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostImagePreview extends StatelessWidget {
  const PostImagePreview({super.key, required this.selecedImage});
  final List<File> selecedImage;

  @override
  Widget build(BuildContext context) {
    final postBlocProvider = context.read<PostBloc>();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    BlocConsumer<PostBloc, PostState>(
                      listener: (context, state) {
                        if (state is PostAdditionSuccessState) {
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
                        }
                      },
                      builder: (context, state) {
                        return TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          child: state is PostAdditionLoadingState
                              ? const CircularProgressIndicator.adaptive()
                              : Text(
                                  'Share',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                          onPressed: () {
                            if (selecedImage.isNotEmpty ||
                                postBlocProvider
                                    .textContentController.text.isNotEmpty) {
                              final post = PostModel(
                                  username: '',
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  textContent: postBlocProvider
                                      .textContentController.text
                                      .trim(),
                                  imageUrls: selecedImage
                                      .map((image) => image.path)
                                      .toList(),
                                  timestamp: DateTime.now(),
                                  likes: [],
                                  comments: []);
                              postBlocProvider.add(PostAddingEvent(
                                  model: post,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid));
                            }
                            postBlocProvider.textContentController.clear();
                          },
                        );
                      },
                    ),
                  ],
                ),
                Container(
                    constraints:
                        BoxConstraints(maxHeight: screenFullHeight / 1.8),
                    width: double.infinity,
                    child: Image.file(
                      (selecedImage[0]),
                      fit: BoxFit.cover,
                    )),
                kHeight10,
                TextField(
                  maxLines: 1,
                  controller: context.read<PostBloc>().textContentController,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
