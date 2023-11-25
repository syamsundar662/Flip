import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip/application/business_logic/bloc/follow/follow_bloc.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key, required this.userId, required this.type});

  final String userId;
  final Friend type;

  @override
  Widget build(BuildContext context) {
    context
        .read<FollowBloc>()
        .add(FetchFriendsListEvent(friend: type, userId: userId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
      ),
      body: BlocBuilder<FollowBloc, FollowState>(
        builder: (context, state) {
          if (state is FriendsListFetchSuccess) {
            if (state.freinds.isEmpty) {
              return  Center(child: Text('No ${type.name}'));
            }
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: state.freinds.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          state.freinds[index].profileImageUrl!),
                      radius: 30,
                    ),
                    title: Text(state.freinds[index].username),
                    trailing: TextButton(
                        onPressed: () {}, child: const Text('remove')),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
