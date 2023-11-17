import 'package:flip/application/business_logic/bloc/post/post_bloc.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/show_sliding.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/image/image_picker.dart';
import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
   const EditProfile({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    final postBlocProvider = context.read<PostBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topImageSection(context), 
          kHeight20,
          TextFormFields(
              padding: const EdgeInsets.all(8),
              controller: postBlocProvider.textContentController,
              hintText: 'Username',
              filledColor: Colors.grey.shade900,
              obscure: false),
          TextFormFields(
              padding: const EdgeInsets.all(8),
              hintText: 'Display Name',
              filledColor: Colors.grey.shade900,
              obscure: false),
          TextFormFields(
              padding: const EdgeInsets.all(8),
              hintText: 'Bio',
              filledColor: Colors.grey.shade900,
              obscure: false),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButtonWidget(
                height: screenFullHeight * .07,
                width: screenFullWidth,
                buttonTitle: const Text('Save Updates'),
                style: const TextStyle(),
                buttonStyles: const ButtonStyle()),
          ),
          kHeight40
        ],
      ),
    );
  }

  Stack _topImageSection(BuildContext context) {
    return Stack(
          children: [
            SizedBox( 
                height: screenFullHeight / 3.5,
                width: double.infinity,
                child: ImageGradient.linear(
                  image: Image.asset(
                    'assets/IMG_2468.JPG',
                    fit: BoxFit.cover,
                  ),
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: const [
                    Color.fromARGB(0, 149, 149, 149),
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                )),
            Positioned(
                left: 20,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        SlideUpWidget().showSlidingBoxWidget(
                            context: context,
                            height: screenFullHeight / 5.4,
                            buttonTitle: [
                              'gallery',
                              'camera'
                            ],
                            buttonIcons: [
                              IconButton(
                                  onPressed: () {PickImage()
                                        .imagePicker(ImageSource.gallery);
                                  },
                                  icon: const Icon(Iconsax.gallery)),
                              IconButton(
                                  onPressed: () {
                                    PickImage()
                                        .imagePicker(ImageSource.camera);
                                  },
                                  icon: const Icon(Iconsax.camera)),
                            ]);
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/testimage.jpeg'),
                        radius: 50,
                      ),
                    )
                  ],
                )),
            Positioned(
                right: 1,
                child: IconButton(
                    onPressed: () {
                      SlideUpWidget().showSlidingBoxWidget(
                          context: context,
                          height: screenFullHeight / 5.4,
                          buttonTitle: [
                            'gallery',
                            'camera'
                          ],
                          buttonIcons: [
                            IconButton(
                                onPressed: () {
                                  PickImage()
                                      .imagePicker(ImageSource.gallery);
                                },
                                icon: const Icon(Iconsax.gallery)),
                            IconButton(
                                onPressed: () {
                                  PickImage().imagePicker(ImageSource.camera);
                                },
                                icon: const Icon(Iconsax.camera)),
                          ]);
                    },
                    icon: const Icon(Iconsax.edit)))
          ],
        );
  }
}
