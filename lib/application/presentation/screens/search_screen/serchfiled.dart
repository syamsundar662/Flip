import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip/application/presentation/screens/user_profile/user_profile.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class SearchResultTileWidget extends StatelessWidget {
  const SearchResultTileWidget(
      {super.key, required this.user, this.friend, this.isOwner = false});

  final UserModel user;
  final Friend? friend;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  UserProfileScreen(postModel: const [], userModel: user),
            ));
      },
      child: Container(
        height: screenFullHeight * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Row(
          children: [
            kWidth10,
            CircleAvatar(
              radius: screenFullWidth * 0.07,
              backgroundImage: CachedNetworkImageProvider(
                user.profileImageUrl!.isEmpty
                    ? "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"
                    : user.profileImageUrl!,
              ),
            ),
            kWidth10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.username,
                ),
                // Row(
                //   children: [
                //     Text(
                //       '@${user.username}',
                //     ),
                //     kHeight10,
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 