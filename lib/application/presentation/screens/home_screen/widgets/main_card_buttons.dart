import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/screens/comment_screen/comment_screen.dart';
import 'package:flip/data/firebase_services/like_data_resourse/like_data_resourse.dart';
import 'package:flip/data/firebase_services/save_post_data_resourse/save_post_service.dart';
import 'package:flip/data/firebase_services/user_data_resourse/user_data.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostMainCommonButtons extends StatefulWidget {
  const PostMainCommonButtons({
    super.key,
    required this.post,
  });
  final PostModel post;
  @override
  State<PostMainCommonButtons> createState() => _PostMainCommonButtonsState();
}

class _PostMainCommonButtonsState extends State<PostMainCommonButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LikeButtonWidget(post: widget.post),
      ],
    );
  }
}

class LikeButtonWidget extends StatefulWidget {
  const LikeButtonWidget({
    super.key,
    required this.post,
  });
  final PostModel post;
  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                LikeDataService().toggleLike(
                    post: widget.post,
                    userId: FirebaseAuth.instance.currentUser!.uid);
                setState(() {});
              },
              icon: widget.post.likes
                      .contains(FirebaseAuth.instance.currentUser!.uid)
                  ? const Icon(
                      Iconsax.like5,
                      color: Colors.red,
                    )
                  : const Icon(
                      Iconsax.like,
                    ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>
                            CommentScreen(postModel: widget.post)));
              },
              icon: const Icon(Iconsax.note),
            ),
            PostSaveButtonWidget(post: widget),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Row(
            children: [
              Text('${widget.post.likes.length.toString()} likes '),
              Text('${widget.post.comments.length.toString()} comments'),
            ],
          ),
        ),
      ],
    );
  }
}

class PostSaveButtonWidget extends StatefulWidget {
  const PostSaveButtonWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final LikeButtonWidget post;

  @override
  State<PostSaveButtonWidget> createState() => _PostSaveButtonWidgetState();
}

class _PostSaveButtonWidgetState extends State<PostSaveButtonWidget> {
  late Future<bool> isPostSaved;

  @override
  void initState() {
    super.initState();
    isPostSaved = _checkIfPostSaved();
  }

  Future<bool> _checkIfPostSaved() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final user = await UserService().fetchDataByUser(currentUser.uid);
      if (user != null) {
        return user.saves.contains(widget.post.post.postId);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isPostSaved,
      builder: (context, snapshot) {
          final isSaved = snapshot.data ?? false;
          return IconButton(
            onPressed: () async {
              await SavePostDataService()
                  .toggleSavedPost(postId: widget.post.post.postId);
              setState(() {
                isPostSaved = _checkIfPostSaved();
              });
            },
            icon: isSaved
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_add_outlined),
          );
       
      },
    );
  }
}
