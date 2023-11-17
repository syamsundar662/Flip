// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CommentScreen extends StatelessWidget {
//   const CommentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(centerTitle: true,title: Text('Comments'), actions: [IconButton(onPressed: (){}, icon: Icon(Icons.done))],),
//       body: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context,index){

//         return ListTile(
//           leading: CircleAvatar(),
//           title: Text('Username'),
//           subtitle:Text('Comment will be here!!') ,
//         );
//       }),
//       bottomNavigationBar: CupertinoSearchTextField() ,

//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/data/firebase/user_data_resourse/user_data.dart';
import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: UserService().fetchComments(widget.postModel.postId),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                List<Comments> comments = snapshot.data!;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(),
                      title: Text(comments[index].userId),
                      subtitle: Text(comments[index].comment),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                suffixIcon: IconButton(
                  icon: Icon(Iconsax.send_1),
                  onPressed: () async {
                    final commentData = Comments(
                        commentId: '',
                        postId: widget.postModel.postId,
                        comment: commentController.text,
                        timeStamp: DateTime.now(),
                        likes: [],
                        userId: FirebaseAuth.instance.currentUser!.uid);
                    await UserService()
                        .addComments(commentData, widget.postModel.postId);
                    print(commentData);
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
