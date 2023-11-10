import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/business_logic/bloc/profile_post/profile_post_bloc.dart';
import 'package:flip/application/business_logic/bloc/user_data/profile_bloc.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_section.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/show_sliding.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin {
    @override
  bool get wantKeepAlive => true;

  final id = FirebaseAuth.instance.currentUser!.uid;

  final email = FirebaseAuth.instance.currentUser!.email; 

  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.read<ProfilePostBloc>().add(ProfilePostDataFetchEvent(id: id));
    context.read<ProfileBloc>().add(UserDataFetchEvent(id: id));
    return SafeArea(
      child: RefreshIndicator.adaptive(
        displacement: 20,
        onRefresh: () async {
          HapticFeedback.heavyImpact();
          context
              .read<ProfilePostBloc>()
              .add(ProfilePostDataFetchEvent(id: id));
          context.read<ProfileBloc>().add(UserDataFetchEvent(id: id));
        },
        child: Scaffold(
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is  UserDataFetchingState) {  
                return Center(child: CircularProgressIndicator.adaptive(),);
              } else if (state is UserDataFetchedState) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: false,
                      centerTitle: false,
                      title: Text(
                        email!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {
                              SlideUpWidget().showSlidingBoxWidget(context);
                            },
                            icon: const Icon(Icons.menu_outlined)),
                      ],
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                      height: screenFullHeight / 3.5,
                                      width: double.infinity,
                                      child: ImageGradient.linear(
                                        image: Image.asset(
                                          "assets/bearded-man-staying-nature.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: const [
                                          Color.fromARGB(0, 149, 149, 149),
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                        ],
                                      )),
                                  const Positioned(
                                      left: 20,
                                      bottom: 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/testimage.jpeg'),
                                            radius: 50,
                                          )
                                        ],
                                      )),
                                  Positioned(
                                    right: 20,
                                    bottom: 0,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Iconsax.sms,
                                        ),
                                        kWIdth20,
                                        TextButton(
                                            style: ButtonStyle(
                                                shape: MaterialStatePropertyAll<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)))),
                                            onPressed: () {},
                                            child: Text(
                                              'Edit profile',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.model.username,
                                      style: GoogleFonts.baloo2(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Text('Out of mind,Out of sight🎭'),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: .1,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '163 posts',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '2k followers',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '538 followings',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '59k likes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 10, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenFullWidth / 2.1,
                                      height: screenFullHeight * .06,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.window_outlined)),
                                    ),
                                    Container(
                                      width: screenFullWidth / 2.1,
                                      height: screenFullHeight * .06,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.notes)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: PostSection(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox(); 
            },
          ),
        ),
      ),
    );
  }
}
