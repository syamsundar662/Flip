import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/firebase/auth_data_resourse/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gradient/image_gradient.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                        Colors.white
                      ],
                    )),
                Positioned(
                    left: 20,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/brunette-girl-walking-through-park-during-autumn.jpg'),
                          radius: 60,
                        )
                      ],
                    )),
                Positioned(
                  right: 0,
                  child: IconButton(
                      onPressed: () {
                        AuthServices().signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                      icon: const Icon(Icons.logout)),
                ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.sms,
                      ),
                      kWIdth20,
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 225, 225, 225)),
                              shape: MaterialStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () {},
                          child: Text('Edit profile')),
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
                  Text('Out of mind,Out of sight🎭'),
                ],
              ),
            ),
            Divider(thickness: .1,), 
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
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
          ],
        ),
      ),
    );
  }
}
