import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title : CupertinoSearchTextField(),
      ),
      body: Center(
        child: Text('Message'),
      ),
    );
  }
}