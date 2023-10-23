import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){}, icon: const Icon(Iconsax.more_circle))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight10,
            const CupertinoSearchTextField(),
            kHeight10,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
               itemCount: 10,
              itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(bottom:5.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(22, 41, 41, 41)
                  ),
                  child: const Row(
                    children: [
                      kWidth10,
                      CircleAvatar(
                      radius: 30,
                    ),kWidth10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Name'),
                        Text('Message'),
                      ],
                    )],
                  ),
                ),
              );
            })
          ],
        ),
      )
    );
  }
}