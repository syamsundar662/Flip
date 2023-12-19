import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/firebase/message_data_resourse/message_data.dart';
import 'package:flip/domain/models/message_model/message.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatUser});

  final UserModel chatUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Row(
            children: [
              kWIdth40,
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(widget.chatUser.profileImageUrl!),
                ),
              ),
            ],
          ),
          title: Text(widget.chatUser.username),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder<List<Message>>(
                  stream: MessageService().getMessage(widget.chatUser.userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final messages = snapshot.data!;
                      if (messages.isEmpty) {
                        return const Center(
                          child: Text('Say hi'),
                        );
                      }
                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final isSender = messages[index].senderId ==
                              FirebaseAuth.instance.currentUser!.uid;
                          return MessageCardWidget(
                            chatUser: widget.chatUser,
                            message: messages[index],
                            isSender: isSender,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.primary,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Type here...',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (messageController.text.isNotEmpty) {
                          await MessageService().sentMessage(
                            toId: widget.chatUser.userId,
                            type: MessageType.text,
                            content: messageController.text,
                          );
                          messageController.clear();
                        }
                      },
                      icon: const Icon(Iconsax.send_1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget({
    Key? key,
    required this.message,
    required this.isSender,
    required this.chatUser,
  }) : super(key: key);

  final UserModel chatUser;
  final Message message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    print(message.sentTime);
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //  isSender ? SizedBox() : Text(formatChatTime(message.sentTime)),

              isSender
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        formatChatTime(message.sentTime),
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  : SizedBox(),

              InkWell(
                onLongPress: () async {
                  await MessageService().deleteMessage(
                      messageId: message.messageId!, toId: message.toId);

                  // showDialog(
                  //   context: context,
                  //   builder: (ctx) => AlertDialog.adaptive(
                  //     title: const Text("Delete message"),
                  //     content: const Text(
                  //       "Are you sure you want to delete?",
                  //     ),
                  //     actions: [
                  //       TextButton(
                  //         onPressed: () async {

                  //         },
                  //         child: Text(
                  //           'Delete',
                  //           style: TextStyle(
                  //               color:
                  //                   Theme.of(context).colorScheme.background),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  constraints: BoxConstraints(maxWidth: screenFullWidth / 2.3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSender ? Colors.blue : Colors.grey,
                  ),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      color: isSender ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              isSender
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        formatChatTime(message.sentTime),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),

              //  isSender ?  CircleAvatar(radius: 8,backgroundImage: NetworkImage(message.),):SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  String formatChatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime); // Return time only
  }
}
