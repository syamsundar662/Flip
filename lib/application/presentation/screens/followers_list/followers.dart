import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key, required this.user});

  final UserModel user;

  getUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: user.followers.length,
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
