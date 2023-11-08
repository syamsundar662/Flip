import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/post/post_bloc.dart';
import 'package:flip/application/presentation/screens/post_screen/post_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostImagePreview extends StatelessWidget {
   PostImagePreview({super.key, required this.selecedImage});
  final List<File> selecedImage;
   List<String> selecedImageUrl = [];

  @override
  Widget build(BuildContext context) {
    final postBlocProvider= context.read<PostBloc>();
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            kHeight60,
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      (MaterialPageRoute(builder: (context) => PostScreen())),
                      (route) => false);
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
            Spacer(),
             BlocConsumer<PostBloc, PostState>(
              listener: (context, state) {
              },
              builder: (context, state) {
                return ElevatedButtonWidget(
                  onEvent: (){
                    if(selecedImage.isNotEmpty && postBlocProvider.textContentController.text.isNotEmpty){

                      // final post = PostModel(userId: FirebaseAuth.instance.currentUser!.uid, textContent: postBlocProvider.textContentController.text, imageUrls: selecedImage, timestamp: DateTime.now(), likes: [], comments: []);
                    }
                  },
                    buttonTitle: Text('Submit'),
                    style: TextStyle(),
                    buttonStyles: ButtonStyle());
                    
              },
            ),
            kHeight40,
          ],
        ),
      ),
    );
  }
}
