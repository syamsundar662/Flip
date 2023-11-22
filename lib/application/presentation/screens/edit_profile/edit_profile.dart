import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip/application/business_logic/bloc/user_profile/profile_bloc.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/show_sliding.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/image/image_picker.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flip/data/firebase/user_data_resourse/user_data.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.model});
  final UserModel model;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    userNameController.text = widget.model.username;
    displayNameController.text = widget.model.displayName ?? '';
    bioContoller.text = widget.model.bio ?? '';
    downloadedProfileUrl = widget.model.profileImageUrl;
    downloadedCoverUrl = widget.model.coverImageUrl;
  }

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController bioContoller = TextEditingController();

  String? coverImageFile;
  File? profileImageFile;
  String? downloadedCoverUrl;
  String? downloadedProfileUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topImageSection(context),
          kHeight20,
          TextFormFields(
              padding: const EdgeInsets.all(8),
              controller: userNameController,
              hintText: 'Username',
              filledColor: Colors.grey.shade900,
              obscure: false),
          TextFormFields(
              controller: displayNameController,
              padding: const EdgeInsets.all(8),
              hintText: 'Display Name',
              filledColor: Colors.grey.shade900,
              obscure: false),
          TextFormFields(
              controller: bioContoller,
              padding: const EdgeInsets.all(8),
              hintText: 'Bio',
              filledColor: Colors.grey.shade900,
              obscure: false),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Colors.transparent,
              )),
              child: const Text(
                'Save changes',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
              ),
              onPressed: ()  {
                final details = UserModel(
                  saves: widget.model.saves,
                    userId: widget.model.userId,
                    username: userNameController.text,
                    email: widget.model.email,
                    bio: bioContoller.text,
                    coverImageUrl: downloadedCoverUrl,
                    displayName: displayNameController.text,
                    profileImageUrl: downloadedProfileUrl,
                    posts: widget.model.posts,
                    followers: widget.model.followers,
                    following: widget.model.following,
                    );

                 UserService()
                    .editUserDetails(details, widget.model.userId);
                context.read<ProfileBloc>().add(UserDataFetchEvent(id: widget.model.userId));
                // print(details);
              },
            ),
          ),
          kHeight40
        ],
      ),
    );
  }

  Stack _topImageSection(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () async {
            final croppedFile = await PickImage().pickAndCropImage();
            if (croppedFile != null) {
              setState(() {
                coverImageFile = croppedFile;
              });
              final url = await PickImage().uploadImage(coverImageFile!);
              downloadedCoverUrl = url;
            }
          },
          child: SizedBox(
              height: screenFullHeight / 3.5,
              width: double.infinity,
              child: ImageGradient.linear(
                image: widget.model.coverImageUrl != null &&
                        widget.model.coverImageUrl!.isNotEmpty &&
                        coverImageFile == null
                    ? Image.network(
                        widget.model.coverImageUrl!,
                        fit: BoxFit.cover,
                      )
                    : coverImageFile != null
                        ? Image.file(
                            File(coverImageFile!),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
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
        ),
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
                              onPressed: () async {
                                final pickedImageFile = await PickImage()
                                    .imagePicker(ImageSource.gallery);
                                setState(() {
                                  profileImageFile = pickedImageFile;
                                });

                                final url = await PickImage()
                                    .uploadImage(pickedImageFile!.path);
                                downloadedProfileUrl = url;
                              },
                              icon: const Icon(Iconsax.gallery)),
                          IconButton(
                              onPressed: () {
                                PickImage().imagePicker(ImageSource.camera);
                              },
                              icon: const Icon(Iconsax.camera)),
                        ]);
                  },
                  child: widget.model.profileImageUrl!.isNotEmpty &&
                          widget.model.profileImageUrl != null &&
                          profileImageFile == null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(
                              widget.model.profileImageUrl!))
                      : profileImageFile != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(profileImageFile!))
                          : const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/IMG_2468.JPG')),
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
                              // PickImage().imagePicker(ImageSource.gallery);
                            },
                            icon: const Icon(Iconsax.gallery)),
                        IconButton(
                            onPressed: () {
                              // PickImage().imagePicker(ImageSource.camera);
                            },
                            icon: const Icon(Iconsax.camera)),
                      ]);
                },
                icon: const Icon(Iconsax.edit)))
      ],
    );
  }
}
