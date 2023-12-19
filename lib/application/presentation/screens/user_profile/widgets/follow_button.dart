import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/screens/chat_screen/chat.dart';
import 'package:flip/data/firebase/follow_data_resource/follow_data_resourse.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FollowButtonWidget extends StatefulWidget {
  const FollowButtonWidget({super.key, required this.user});
  final UserModel user;

  @override
  State<FollowButtonWidget> createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!.uid != widget.user.userId
        ? SizedBox(
            // width: screenFullWidth * 0.23,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(chatUser: widget.user)));
                    },
                    icon: const Icon(Iconsax.message)),
                TextButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      final userId = FirebaseAuth.instance.currentUser!.uid;
                      if (widget.user.followers.contains(userId)) {
                        widget.user.followers.remove(userId);
                        FollowDataSources().unfollowUser(
                            uid: userId, followId: widget.user.userId);
                      } else {
                        widget.user.followers.add(userId);
                        FollowDataSources().followUser(
                            uid: userId, followId: widget.user.userId);
                      }
                      setState(() {});
                    },
                    child: Text(
                        widget.user.followers.contains(
                                FirebaseAuth.instance.currentUser!.uid)
                            ? 'Following'
                            : 'Follow',
                        style: TextStyle(
                          color: widget.user.followers.contains(
                                  FirebaseAuth.instance.currentUser!.uid)
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.background,
                        ))),
              ],
            ),
          )
        : const SizedBox();
  }
}