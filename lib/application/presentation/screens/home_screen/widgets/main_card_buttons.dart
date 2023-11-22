import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/screens/comment_screen/comment_screen.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostMainCommonButtons extends StatefulWidget {
  const PostMainCommonButtons({super.key,required this.post,
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
                PostServices().toggleLike(
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
                        builder: (context) =>  CommentScreen(postModel: widget.post)));
              },
              icon: const Icon(Iconsax.note),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Iconsax.share),
            // ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.save_2),
            ),
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

// class CommentButtonWidget extends StatefulWidget {
//   const CommentButtonWidget({
//     super.key,
//     required this.post,
//   });
//   final PostModel post;

//   @override
//   State<CommentButtonWidget> createState() => _CommentButtonWidgetState();
// }

// class _CommentButtonWidgetState extends State<CommentButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         IconButton(onPressed: () {}, icon: const Icon(Iconsax.note)),
//         Text('${widget.post.comments.length.toString()} comments'),
//       ],
//     );
//   }
// }
