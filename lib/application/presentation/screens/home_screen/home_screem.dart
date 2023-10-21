import 'package:flip/application/presentation/screens/message_screen/message_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:flip/application/presentation/widgets/flip_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    kWidth10,
                    FlipLogoText(
                      logoSize: 35,
                    ),
                    Spacer(),
                    IconButton(onPressed: () { 
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>MessageScreen()));
                    }, icon: Icon(Iconsax.message)),
                  ],
                ),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/IMG_2468.JPG'),
                              radius: 35,
                            ));
                      }),
                ),
                Divider(
                  thickness: .1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/IMG_2468.JPG'),
                                    radius: 23,
                                  ),
                                  kWidth10,
                                  Text(
                                    'James xavier',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Icon(Icons.more_vert)
                                ],
                              ),
                              kHeight10,
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxHeight: screenFullHeight / 1.8),
                                  width: double.infinity,
                                  child: Image.asset(
                                    'assets/IMG_2468.JPG',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Iconsax.like),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Iconsax.note),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Iconsax.share),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Iconsax.save_2),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: .1,
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
