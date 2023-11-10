import 'package:flip/application/presentation/screens/home_screen/widgets/main_card_buttons.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/show_sliding.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/timestamp/time_stamp.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/material.dart';

class PostViewScreen extends StatelessWidget {
  const PostViewScreen({super.key, required this.model});

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/IMG_2468.JPG'),
                        radius: 18,
                      ),
                      kWidth10,
                      Text(
                        model.username,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          SlideUpWidget().showSlidingBoxWidget(
                              context,
                              screenFullHeight / 5,
                              SlideUpWidget.optionsForProfilePostViewScreen,
                              SlideUpWidget.optionIconListForProfilePostViewScreen);
                          // showSlidingBox(
                          //     context: context,
                          //     box: SlidingBox(
                          //       maxHeight: screenFullHeight / 5,
                          //       color: Theme.of(context).colorScheme.onTertiary,
                          //       style: BoxStyle.shadow,
                          //       draggableIconBackColor:
                          //           Theme.of(context).colorScheme.onTertiary,
                          //       body: SizedBox(
                          //         height: screenFullHeight / 5,
                          //         child: ListView.builder(
                          //           itemCount: 1,
                          //           itemBuilder: (context, index) {
                          //             return const ListTile(
                          //               leading: Icon(Icons.delete),
                          //               title: Text('delete'),
                          //             );
                          //           },
                          //         ),
                          //       ),
                          //     ));

                          // Navigator.pop(context);

                          // context
                          //     .read<ProfilePostBloc>()
                          //     .add(ProfilePostDataFetchEvent(id: model.userId));
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    ],
                  ),
                  kHeight10,
                  model.imageUrls.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            constraints: BoxConstraints(
                                maxHeight: screenFullHeight / 1.8),
                            width: double.infinity,
                            child: Image.network(
                              model.imageUrls[0],
                              fit: BoxFit.cover,
                            ),
                          ))
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
                  const PostMainCommonButtons(),
                  const Row(
                    children: [
                      kWidth10,
                      Text(
                        '324 likes and ',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      // kWidth10,
                      Text(
                        '56 comments',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  model.imageUrls.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.5, right: 10),
                          child: Text(
                            model.textContent,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.5),
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
}
