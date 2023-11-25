import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip/application/presentation/screens/edit_profile/edit_profile.dart';
import 'package:flip/application/presentation/screens/followers_list/followers.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_section.dart';
import 'package:flip/data/firebase/save_post_data_service/save_post_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/business_logic/bloc/user_profile/profile_bloc.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/show_sliding.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override 
  bool get wantKeepAlive => true;

  final id = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    SavePostDataService().fetchSavedPosts(id);
    context.read<ProfileBloc>().add(UserDataFetchEvent(id: id));
    context.read<ProfileBloc>().add(ProfilePostDataFetchEvent(id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: RefreshIndicator.adaptive(
        displacement: 20,
        onRefresh: () async {
          HapticFeedback.heavyImpact();
          context.read<ProfileBloc>().add(UserDataFetchEvent(id: id));
          context.read<ProfileBloc>().add(ProfilePostDataFetchEvent(id: id));
        },
        child: Scaffold(
          body: DefaultTabController(
            length: 3,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (pre, cur) => cur is UserDataFetchedState,
              builder: (ctx, state) {
                if (state is UserDataFetchedState) {
                  return CustomScrollView(
                    slivers: [
                      _appBarSection(state, context),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _topPictureSection(context, state),
                                _nameAndBioSection(state),
                                const Divider(
                                  thickness: .1,
                                ),
                                _middleSection(state),
                                postTabBarSection(context),

                                // Wrap TabBar and TabBarView in Expanded
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
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
            Tab(text: 'Saves'),
          ],
        ),
        SizedBox(
          height: screenFullHeight / 1.27,
          child: const TabBarView(
            children: [
              PostSection(),
              ThoughtsPostSection(),
              SavedPostSection(),
            ],
          ),
        ),
      ],
    );
  }

  SliverAppBar _appBarSection(
      UserDataFetchedState state, BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      centerTitle: false,
      title: Text(
        '@${state.model.email}',
        style: const TextStyle(fontSize: 15),
      ),
      actions: [
        IconButton(
            onPressed: () {
              SlideUpWidget().showSlidingBoxWidget(
                  context: context,
                  height: screenFullHeight / 2.35,
                  buttonTitle: SlideUpWidget.optionsForProfileScreen,
                  buttonIcons: SlideUpWidget.optionIconListForProfileScreen);
            },
            icon: const Icon(Icons.menu_outlined)),
      ],
    );
  }

  Stack _topPictureSection(BuildContext context, UserDataFetchedState state) {
    return Stack(
      children: [
        SizedBox(
            height: screenFullHeight / 3.2,
            width: double.infinity,
            child: ImageGradient.linear(
              image: state.model.coverImageUrl!.isEmpty
                  ? Image.asset(
                      "assets/default-fallback-image.png",
                      opacity: const AlwaysStoppedAnimation(.1),
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      state.model.coverImageUrl!,
                      fit: BoxFit.cover,
                    ),
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
                  child: state.model.profileImageUrl != null &&
                          state.model.profileImageUrl!.isNotEmpty
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(
                              state.model.profileImageUrl!))
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
          child: Row(
            children: [
              // InkWell(
              //   onTap: () {
              //     AuthServices().signOut();
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const LoginScreen()));
              //   },
              //   child: const Icon(
              //     Iconsax.sms,
              //   ),
              // ),
              // kWIdth20,
              TextButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => EditProfile(
                                  model: state.model,
                                )));
                  },
                  child: Text(
                    'Edit profile',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )),
            ],
          ),
        )
      ],
    );
  }

  Padding _nameAndBioSection(UserDataFetchedState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight10,
          Text(
            state.model.displayName!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(state.model.bio!),
        ],
      ),
    );
  }

  Padding _middleSection(UserDataFetchedState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${state.model.posts!.length.toString()} posts",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FollowersScreen(
                            userId: state.model.userId,type: Friend.follower,
                          )));
            },
            child: Text(
              '${state.model.followers.length.toString()} followers',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  FollowersScreen(type: Friend.following,userId: state.model.userId,)));
            },
            child: Text(
              '${state.model.following.length.toString()} followings',
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
