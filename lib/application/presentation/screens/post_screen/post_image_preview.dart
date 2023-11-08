import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/post/post_bloc.dart';
import 'package:flip/application/presentation/screens/root_screen/root_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            kHeight60,
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            SizedBox(
                height: screenFullHeight / 1.5,
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
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              cursorColor: Theme.of(context).colorScheme.secondary,
            ),
            const Spacer(),
            BlocConsumer<PostBloc, PostState>(
              listener: (context, state) {
                if (state is PostAdditionSuccessState) {
                  AnimatedSnackBar.material(
                    'success',
                    type: AnimatedSnackBarType.error,
                    mobileSnackBarPosition: MobileSnackBarPosition.top,
                  ).show(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const RootScreen()),
                      (route) => false);
                }
              },
              builder: (context, state) {
                return ElevatedButtonWidget(
                    onEvent: () {
                      if (selecedImage.isNotEmpty &&
                          postBlocProvider
                              .textContentController.text.isNotEmpty) {
                        final post = PostModel(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            textContent:
                                postBlocProvider.textContentController.text,
                            imageUrls: selecedImage
                                .map((image) => image.path)
                                .toList(),
                            timestamp: DateTime.now(),
                            likes: [],
                            comments: []);
                        postBlocProvider.add(PostAddingEvent(model: post));
                      }
                    },
                    buttonTitle: state is PostAdditionLoadingState
                        ? const CircularProgressIndicator.adaptive()
                        : const Text('Submit'),
                    style: const TextStyle(),
                    buttonStyles: const ButtonStyle());
              },
            ),
            kHeight40,
          ],
        ),
      ),
    );
  }
}
