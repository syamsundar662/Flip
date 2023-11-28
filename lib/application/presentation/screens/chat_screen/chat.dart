// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flip/application/presentation/utils/constants/constants.dart';
// import 'package:flip/data/firebase/message_data_resourse/message_data.dart';
// import 'package:flip/domain/models/message_model/message.dart';
// import 'package:flip/domain/models/user_model/user_model.dart';
// import 'package:flutter/material.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key, required this.chatUser});

//   final UserModel chatUser;

//   @override
//   Widget build(BuildContext context) {
//     print(chatUser.userId); 
//   final TextEditingController messageController =TextEditingController();
//     return Builder(builder: (context) {
//       return SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             // flexibleSpace: Row(children: [CircleAvatar()],),
//             leading:  CircleAvatar(backgroundImage: NetworkImage(chatUser.profileImageUrl!),),
//             actions: [
//               IconButton(
//                   onPressed: () async { 
//                     await MessageService().sentMessage(
//                         toId: chatUser.userId,
//                         type: MessageType.text,
//                         content:messageController.text);
//                         messageController.clear();
//                   },
//                   icon: const Icon(Icons.send)) 
//             ],
//             title:  Text(chatUser.username),
//             centerTitle: true,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: StreamBuilder<List<Message>>(
//                       stream: MessageService().getMessage(chatUser.userId),
//                       builder: (context, snapshot) {
//                         print(snapshot.data);
//                         if (snapshot.hasData) {
//                           final messages = snapshot.data!;
//                           if (messages.isEmpty) {
//                             return const Center(
//                               child: Text('Say hai'),
//                             );
//                           }
//                           return ListView.builder(
//                               itemCount: messages.length,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 return MessageCardWidget(
//                                   message: messages[index],
//                                 );
//                               });
//                         } else {
//                           return const Center(
//                             child: CircularProgressIndicator.adaptive(),
//                           );
//                         }
//                       }),
//                 ),
//                  TextField(
//                   controller: messageController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), hintText: 'type here...'),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// class MessageCardWidget extends StatelessWidget {
//   const MessageCardWidget({
//     super.key,
//     required this.message,
//   });
//   final Message message;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment:
//           message.senderId != FirebaseAuth.instance.currentUser!.uid
//               ? MainAxisAlignment.start
//               : MainAxisAlignment.end,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           constraints: BoxConstraints(maxWidth: screenFullWidth / 2.3),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.teal,
//           ),
//           child: Text(message.content),
//         ),
//       ],
//     );
//   }
// }

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/firebase/message_data_resourse/message_data.dart';
import 'package:flip/domain/models/message_model/message.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.chatUser}) : super(key: key);

  final UserModel chatUser;

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
                  backgroundImage: NetworkImage(chatUser.profileImageUrl!),
                ),
              ),
            ],
          ),
          title: Text(chatUser.username),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder<List<Message>>(
                  stream: MessageService().getMessage(chatUser.userId),
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
                            toId: chatUser.userId,
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
  }) : super(key: key);

  final Message message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
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
      ],
    );
  }
}
