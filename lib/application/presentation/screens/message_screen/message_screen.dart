import 'package:flip/application/presentation/screens/chat_screen/chat.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/firebase/message_data_resourse/message_data.dart';
import 'package:flip/domain/models/message_model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Iconsax.more_circle))
          ],
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                kHeight10,
                MessageTileWidget() //message tiles
              ],
            ),
          ),
        ));
  }
}

class MessageTileWidget extends StatelessWidget {
  const MessageTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MessageService().getChatWithProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('No chats'),
            );
          }
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  chatUser: data.userProfile,
                                ))),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: const Color.fromARGB(22, 41, 41, 41)
                      ),
                      child: Row(
                        children: [
                          kWidth10,
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            chatUser: data.userProfile,
                                          )));
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  data.userProfile.profileImageUrl!),
                              radius: 30,
                            ),
                          ),
                          kWidth10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data.userProfile.username),
                              StreamBuilder<Message?>(
                                  stream: MessageService()
                                      .getLastMessage(data.userProfile.userId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final lastMessage = snapshot.data!;
                                      return Text(lastMessage.content);
                                    } else {
                                      return SizedBox();
                                    }
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
