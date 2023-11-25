import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/screens/followers_list/followers.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_section.dart';
import 'package:flip/application/presentation/screens/user_profile/user_posts.dart';
import 'package:flip/data/firebase/follow_data_resource/follow_data_resourse.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen(
      {Key? key, required this.userModel, required this.postModel})
      : super(key: key);

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
      actions: [
        IconButton(
            onPressed: () {
              // SlideUpWidget().showSlidingBoxWidget(
              //     context: context,
              //     height: screenFullHeight / 2.35,
              //     buttonTitle: SlideUpWidget.optionsForProfileScreen,
              //     buttonIcons: SlideUpWidget.optionIconListForProfileScreen);
            },
            icon: const Icon(Icons.menu_outlined)),
      ],
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
                            userId: widget.userModel.userId,type: Friend.follower,
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
                      builder: (context) =>  FollowersScreen(
                        type: Friend.following,userId: widget.userModel.userId,
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

class FollowButtonWidget extends StatefulWidget {
  const FollowButtonWidget({super.key, required this.user});
  final UserModel user;

  @override
  State<FollowButtonWidget> createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!.uid != widget.user.userId
        ? SizedBox(
            width: screenFullWidth * 0.23,
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  final userId = FirebaseAuth.instance.currentUser!.uid;
                  if (widget.user.followers.contains(userId)) {
                    widget.user.followers.remove(userId);
                    FollowDataSources().unfollowUser(
                        uid: userId, followId: widget.user.userId);
                  } else {
                    widget.user.followers.add(userId);
                    FollowDataSources()
                        .followUser(uid: userId, followId: widget.user.userId);
                  }
                  setState(() {});
                },
                child: Text(
                    widget.user.followers
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? 'Following'
                        : 'Follow',
                    style: TextStyle(
                      color: widget.user.followers
                              .contains(FirebaseAuth.instance.currentUser!.uid)
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.background,
                    ))),
          )
        : const SizedBox();
  }
}















// import 'package:flip/application/presentation/screens/edit_profile/edit_profile.dart';
// import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
// import 'package:flip/application/presentation/screens/profile_screen/widgets/post_section.dart';
// import 'package:flip/data/firebase/auth_data_resourse/auth_services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_gradient/image_gradient.dart';
// import 'package:flip/application/presentation/utils/constants/constants.dart';
// import 'package:flip/application/business_logic/bloc/user_profile/profile_bloc.dart';
// import 'package:flip/application/presentation/screens/profile_screen/widgets/show_sliding.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   final id = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     context.read<ProfileBloc>().add(UserDataFetchEvent(id: id));

//     return SafeArea(
//       child: RefreshIndicator.adaptive(
//         displacement: 20,
//         onRefresh: () async {
//           HapticFeedback.heavyImpact();
//           context.read<ProfileBloc>().add(ProfilePostDataFetchEvent(id: id));
//         },
//         child: DefaultTabController(
//           length: 3,
//           child: Scaffold(
//             body: BlocBuilder<ProfileBloc, ProfileState>(
//               buildWhen: (pre, cur) => cur is UserDataFetchedState,
//               builder: (ctx, state) {
//                 if (state is UserDataFetchedState) {
//                   return NestedScrollView(
//                       // physics: NeverScrollableScrollPhysics(),
//                       body: const TabBarView(
//                           // physics: NeverScrollableScrollPhysics(),
//                           children: [
//                             PostSection(),
//                             ThoughtsPostSection(),
//                             Text('saves')
//                           ]),
//                       headerSliverBuilder: (_, innerBoxScrolled) {
//                         return [
//                           _appBarSection(state, context),
//                         ];
//                       });
//                 }
//                 return const SizedBox();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Padding _middleSection(UserDataFetchedState state) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "${state.model.posts!.length.toString()} posts",
//             style: const TextStyle(fontWeight: FontWeight.w500),
//           ),
//           const Text(
//             '2k followers',
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//           const Text(
//             '538 followings',
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//           const Text(
//             '59k likes',
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }
//   Padding _nameAndBio(UserDataFetchedState state) {
//     return Padding(
//       padding:  EdgeInsets.only(left: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             state.model.username,
//             textAlign: TextAlign.center,
//             style:
//                 GoogleFonts.baloo2(fontSize: 22, fontWeight: FontWeight.w500),
//           ),
//            Text(state.model.bio!),
//         ],
//       ),
//     );
//   }
//   Stack _topPictureSection(BuildContext context, UserDataFetchedState state) {
//     return Stack(
//       children: [
//         SizedBox(
//             height: screenFullHeight / 3.5,
//             width: double.infinity,
//             child: ImageGradient.linear(
//               image: Image.asset(
//                 "assets/bearded-man-staying-nature.jpg",
//                 fit: BoxFit.cover,
//               ),
//               begin: Alignment.bottomCenter,
//               end: Alignment.topCenter,
//               colors: [
//                 const Color.fromARGB(0, 149, 149, 149),
//                 Colors.white,
//                 Colors.white,
//                 Colors.white,
//                 Theme.of(context).colorScheme.background,
//               ],
//             )),
//         const Positioned(
//             left: 20,
//             bottom: 0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage('assets/testimage.jpeg'),
//                   radius: 50,
//                 )
//               ],
//             )),
//         Positioned(
//           right: 20,
//           bottom: 0,
//           child: Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   AuthServices().signOut();
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LoginScreen()));
//                 },
//                 child: const Icon(
//                   Iconsax.sms,
//                 ),
//               ),
//               kWIdth20,
//               TextButton(
//                   style: ButtonStyle(
//                       shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)))),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         CupertinoPageRoute(
//                             builder: (context) => EditProfile(
//                                   model: state.model,
//                                 )));
//                   },
//                   child: Text(
//                     'Edit profile',
//                     style: TextStyle(
//                         color: Theme.of(context).colorScheme.secondary),
//                   )),
//             ],
//           ),
//         )
//       ],
//     );
//   }
//   SliverAppBar _appBarSection(
//       UserDataFetchedState state, BuildContext context) {
//     return SliverAppBar(
//       collapsedHeight: screenFullHeight / 2.6,
//       flexibleSpace: ListView(
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           _topPictureSection(context, state),
//           _nameAndBio(state),
//           const Divider(
//             thickness: .1,
//           ),
//           _middleSection(state),
//         ],
//       ),
//       primary: true,
//       floating: true,
//       snap: false,
//       pinned: false,
//       centerTitle: false,
//       title: Text(
//         state.model.username,
//         style: const TextStyle(fontSize: 15),
//       ),
//       actions: [
//         IconButton(
//             onPressed: () {
//               SlideUpWidget().showSlidingBoxWidget(
//                   context: context,
//                   height: screenFullHeight / 2,
//                   buttonTitle: SlideUpWidget.optionsForProfileScreen,
//                   buttonIcons: SlideUpWidget.optionIconListForProfileScreen);
//             },
//             icon: const Icon(Icons.menu_outlined)),
//       ],
//       bottom: const TabBar(
//           physics: NeverScrollableScrollPhysics(),
//           labelColor: Colors.amber,
//           tabs: [
//             Tab(
//               child: Text('Posts'),
//             ),
//             Tab(
//               child: Text('Thoughts'),
//             ),
//             Tab(
//               child: Text('Saves'),
//             ),
//           ]),
//     );
//   }
// }
