import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Flip'),
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.message_rounded))],
             ),
    );
  }
}