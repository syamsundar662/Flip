import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flip/application/presentation/screens/followers_list/followers.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_section.dart';
import 'package:flip/application/presentation/screens/user_profile/user_posts.dart';
import 'package:flip/application/presentation/screens/user_profile/widgets/follow_button.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flip/data/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen(
      {super.key, required this.userModel, required this.postModel});

  final UserModel userModel;
  final List<PostModel> postModel;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.background,
      child: RefreshIndicator.adaptive(
        displacement: 20,
        onRefresh: () async {
          HapticFeedback.heavyImpact();
        },
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            child: CustomScrollView(
              slivers: [
                _appBarSection(context),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _topPictureSection(context),
                          _nameAndBioSection(),
                          const Divider(
                            thickness: .1,
                          ),
                          _middleSection(),
                          postTabBarSection(context),

                          // Wrap TabBar and TabBarView in Expanded
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column postTabBarSection(BuildContext context) {
    return Column(
      children: [
        TabBar(
          unselectedLabelColor: Theme.of(context).colorScheme.secondary,
          labelColor: Theme.of(context).colorScheme.onPrimary,
          tabs: const [
            Tab(text: 'Posts'),
            Tab(text: 'Thoughts'),
          ],
        ),
        SizedBox(
          height: screenFullHeight / 1.27,
          child: TabBarView(
            children: [
              UserPostSection(userData: widget.userModel),
              const ThoughtsPostSection(),
            ],
          ),
        ),
      ],
    );
  }

  SliverAppBar _appBarSection(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      centerTitle: false,
      title: Text(
        '@${widget.userModel.email}',
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  Stack _topPictureSection(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: screenFullHeight / 3.2,
            width: double.infinity,
            child: ImageGradient.linear(
              image: widget.userModel.coverImageUrl!.isNotEmpty &&
                      widget.userModel.coverImageUrl != null
                  ? Image.network(
                      widget.userModel.coverImageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/default-fallback-image.png'),
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: const [
                Color.fromARGB(0, 255, 255, 255),
                Colors.white,
                Colors.white,
                Colors.white,
              ],
            )),
        Positioned(
            left: 10,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: widget.userModel.profileImageUrl!.isNotEmpty &&
                          widget.userModel.profileImageUrl != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(
                              widget.userModel.profileImageUrl!))
                      : const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/default-fallback-image.png')),
                )
              ],
            )),
        Positioned(
          right: 10,
          bottom: 0,
          child: FollowButtonWidget(user: widget.userModel),
        )
      ],
    );
  }

  Padding _nameAndBioSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight10,
          Text(
            widget.userModel.username,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(widget.userModel.bio!),
        ],
      ),
    );
  }

  Padding _middleSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${widget.userModel.posts!.length.toString()} posts",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FollowersScreen(
                            userId: widget.userModel.userId,
                            type: Friend.follower,
                          )));
            },
            child: Text(
              '${widget.userModel.followers.length.toString()} followers',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FollowersScreen(
                            type: Friend.following,
                            userId: widget.userModel.userId,
                          )));
            },
            child: Text(
              '${widget.userModel.following.length.toString()} following',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const Text(
            '0 likes',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
