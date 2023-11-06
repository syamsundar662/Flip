import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_section.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/show_sliding.dart';
import 'package:flip/data/firebase/auth_data_resourse/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: const Text(
              '@syamsundar',
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSlidingBoxWidget(context);
                  },
                  icon: const Icon(Icons.list)),
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
                                "assets/bearded-man-staying-nature.jpg",          fit: BoxFit.cover,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/testimage.jpeg'),
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
                                                  BorderRadius.circular(10)))),
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
                            'Syam sundar',
                            style: GoogleFonts.baloo2(
                                fontSize: 22, fontWeight: FontWeight.w500),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '163 posts',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '2k followers',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '538 followings',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '59k likes',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 10, bottom: 3),
                      child: Container(
                        width: double.infinity,
                        height: screenFullHeight * .06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.primary),
                        child: IconButton(
                            onPressed: () {
                              AuthServices().signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            },
                            icon: const Icon(Icons.list_alt)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: PostSection(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
