import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/comment/comments_bloc.dart';
import 'package:flip/application/business_logic/bloc/comment/comments_state.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/timestamp/time_stamp.dart';
import 'package:flip/data/models/comment_model/comment_model.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.postModel});
  final PostModel postModel;

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final commentBlocProvider = context.read<CommentsBloc>();
    commentBlocProvider.add(CommentsFetchEvent(postId: widget.postModel.postId));

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
                  if (state.comments!.isEmpty) {
                    return const Center(
                      child: Text('No comments'),
                    );
                  }
                  final data = state.comments;
                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          showDeleteDialog(state.comments![index].comment);
                        },
                        child: ListTile(
                          leading: state.comments![index].user.profileImageUrl!
                              .isNotEmpty
                              ? CircleAvatar(

                              backgroundColor: Colors.grey[900],
                                  backgroundImage: CachedNetworkImageProvider(
                                      state.comments![index].user.profileImageUrl!),
                                )
                              :  CircleAvatar(

                              backgroundColor: Colors.grey[900],
                                ),
                          title: Text(data[index].user.username),
                          subtitle: Text(data[index].comment.comment,),
                          trailing: Text(timeAgo(data[index].comment.timeStamp)),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: CommentAddField(
              commentBlocProvider: commentBlocProvider,
              postModel: widget.postModel,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void showDeleteDialog(Comments comment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Comment?'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: <Widget>[
            TextButton( 
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton( 
              onPressed: () {
                context.read<CommentsBloc>().add(CommentsDeleteEvent(comment: comment));
                Navigator.of(context).pop();
              },
              child: const Text('DELETE'),
            ), 
          ],
        );
      },
    ); 
  }
}

class CommentAddField extends StatelessWidget {
  const CommentAddField({
    super.key,
    required this.commentBlocProvider,
    required this.postModel,
  });

  final CommentsBloc commentBlocProvider;
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenFullHeight * .07,
      child: TextField(
        controller: commentBlocProvider.commentController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Theme.of(context).colorScheme.primary,
          filled: true,
          hintText: 'Add a comment...',
          suffixIcon: GestureDetector(
            onTap: () async {
              if (commentBlocProvider.commentController.text.isNotEmpty) {
                final commentData = Comments(
                  commentId: '',
                  postId: postModel.postId,
                  comment: commentBlocProvider.commentController.text.trim(),
                  timeStamp: DateTime.now(),
                  likes: [],
                  userId: FirebaseAuth.instance.currentUser!.uid,
                );
                commentBlocProvider.add(CommentsAddButtonEvent(model: commentData));
              }
            },
            child: const Icon(Iconsax.send_1),
          ),
        ),
      ),
    );
  }
}
