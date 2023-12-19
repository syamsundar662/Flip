import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/firebase/message_data_resourse/message_data.dart';
import 'package:flip/domain/models/message_model/message.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatUser});

  final UserModel chatUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0.0; // Store last scroll position

  @override
  void initState() {
    super.initState();
    _loadScrollPosition(); // Load scroll position on init
  }

  _loadScrollPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastScrollOffset = prefs.getDouble('lastScrollOffset') ?? 0.0;
    });
  }

  _saveScrollPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('lastScrollOffset', _scrollController.position.pixels);
  }

  @override
  void dispose() {
    _saveScrollPosition(); // Save scroll position on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        appBar: AppBar(
          //... (your existing app bar)
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
                      messages.sort((a, b) => b.sentTime.compareTo(a.sentTime)); // Sort messages in reverse order

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollController.jumpTo(_lastScrollOffset);
                      });

                      return ListView.builder(
                        reverse: true, // Display messages in reverse order
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final isSender = messages[index].senderId == FirebaseAuth.instance.currentUser!.uid;
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
                              borderRadius: BorderRadius.circular(20),
                            ),
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
    super.key,
    required this.message,
    required this.isSender,
    required this.chatUser,
  });

  final UserModel chatUser;
  final Message message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              isSender
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        formatChatTime(message.sentTime),
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  : const SizedBox(),
              InkWell(
                onLongPress: () async {
                  // ... (your message deletion logic)
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
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        formatChatTime(message.sentTime),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
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
