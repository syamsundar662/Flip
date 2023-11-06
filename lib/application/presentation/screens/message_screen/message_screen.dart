import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Iconsax.more_circle))
          ],
        ),
        body: const SingleChildScrollView(
          child:  Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                kHeight10,
                CupertinoSearchTextField(),
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
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(22, 41, 41, 41)),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/brunette-girl-walking-through-park-during-autumn.jpg'),  
                    radius: 30,
                  ),
                  kWidth10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Name'),
                      Text('Message'),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
