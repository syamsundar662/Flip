import 'package:flutter/material.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following'),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: const CircleAvatar(
                radius: 30,
              ),
              title: const Text('follower'),
              trailing:
                  TextButton(onPressed: () {}, child: const Text('remove')),
            );
          }),
    );
  }
}
