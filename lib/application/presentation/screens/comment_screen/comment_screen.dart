import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/bloc/comments_bloc.dart';
import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final commentBlocProvider = context.read<CommentsBloc>();
    commentBlocProvider
        .add(CommentsFetchEvent(postId: widget.postModel.postId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CommentsBloc, CommentsState>(
              builder: (context, state) {
                if (state is CommentsFetchingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CommentsFetchedState ||
                    state is CommentsAddSuccessState) {
                  if (state.comments.isEmpty) {
                    return const Center(
                      child: Text('No comments'),
                    );
                  }
                  final data = state.comments;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: state.comments[index].user.profileImageUrl!
                                .isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    state
                                        .comments[index].user.profileImageUrl!),
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                        title: Text(data[index].user.username),
                        subtitle: Text(data[index].comment.comment),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: commentBlocProvider.commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                suffixIcon: IconButton(
                  icon: const Icon(Iconsax.send_1),
                  onPressed: () async {
                    final commentData = Comments(
                        commentId: '',
                        postId: widget.postModel.postId,
                        comment: commentBlocProvider.commentController.text,
                        timeStamp: DateTime.now(),
                        likes: [],
                        userId: FirebaseAuth.instance.currentUser!.uid);
                    commentBlocProvider
                        .add(CommentsAddButtonEvent(model: commentData));
                    commentBlocProvider.commentController.clear();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
