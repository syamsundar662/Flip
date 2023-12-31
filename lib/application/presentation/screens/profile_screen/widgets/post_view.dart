import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/post/post_bloc.dart';
import 'package:flip/application/business_logic/bloc/user_profile/profile_bloc.dart';
import 'package:flip/application/presentation/screens/home_screen/widgets/main_card_buttons.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/timestamp/time_stamp.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:iconsax/iconsax.dart';

class PostViewScreen extends StatelessWidget {
  const PostViewScreen({super.key, required this.model});

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      kWidth10,
                       CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        backgroundImage: const AssetImage('assets/IMG_2468.JPG'),
                        radius: 18,
                      ),
                      kWidth10,
                      Text(
                        model.username,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      model.userId == FirebaseAuth.instance.currentUser!.uid
                          ? IconButton(
                              onPressed: () {
                                showSlidingBoxWidget(
                                    context: context,
                                    height: screenFullHeight / 4.7,
                                    buttonTitle:
                                        optionsForProfilePostViewScreen,
                                    buttonIcons:
                                        optionIconListForProfilePostViewScreen);
                              },
                              icon: const Icon(Icons.more_vert_outlined))
                          : const SizedBox()
                    ],
                  ),
                  kHeight10,
                  model.imageUrls.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              // padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(
                                  maxHeight: screenFullHeight / 1.8),
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: model.imageUrls[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color.fromARGB(20, 159, 159, 159),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              model.textContent,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                  PostMainCommonButtons(post: model),
                  model.imageUrls.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 14, right: 10),
                          child: Text(
                            model.textContent,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                    ),
                    child: Text(
                      timeAgo(model.timestamp),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const Divider(
                    thickness: .1,
                  )
                ],
              );
            }));
  }

  Future<dynamic> showSlidingBoxWidget(
      {required BuildContext context,
      required double height,
      // PostModel? model,
      required List<String> buttonTitle,
      required List<Icon> buttonIcons}) {
    return showSlidingBox(
        barrierDismissible: true,
        context: context,
        box: SlidingBox(
          collapsed: true,
          draggable: true,
          maxHeight: height,
          color: Theme.of(context).colorScheme.onTertiary,
          style: BoxStyle.shadow,
          draggableIconBackColor: Theme.of(context).colorScheme.onTertiary,
          body: _body(buttonTitle, buttonIcons, context),
        ));
  }

  _body(
    List<String> buttonTitle,
    List<Icon> buttonIcons,
    BuildContext context,
  ) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostDeleteSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          context
              .read<ProfileBloc>()
              .add(ProfilePostDataFetchEvent(id: model.userId));
          context.read<ProfileBloc>().add(UserDataFetchEvent(id: model.userId));
        }
      },
      child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (ctx, index) {
            return const Divider(
              thickness: .001,
            );
          },
          itemCount: buttonIcons.length,
          itemBuilder: (itemBuilder, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog.adaptive(
                    title: const Text("Delete post"),
                    content: const Text(
                      "Are you sure you want to delete?",
                    ),
                    actions: <Widget>[
                      BlocConsumer<PostBloc, PostState>(
                        listener: (context, state) {
                          if (state is PostDeleteSuccessState) {
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              if (index == 1) {
                                context.read<PostBloc>().add(PostDeleteEvent(
                                    model.userId,
                                    postId: model.postId));
                              }
                            },
                            child: state is PostDeletionState
                                ? CircularProgressIndicator.adaptive(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  )
                                : Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ListTile(
                  leading: buttonIcons[index],
                  title: Text(buttonTitle[index]),
                ),
              ),
            );
          }),
    );
  }

  static List<String> optionsForProfilePostViewScreen = [
    'Edit post',
    'Delete',
  ];
  static List<Icon> optionIconListForProfilePostViewScreen = [
    const Icon(
      Iconsax.edit,
    ),
    const Icon(
      Iconsax.profile_delete,
    ),
  ];
}
