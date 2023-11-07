import 'package:flip/application/presentation/screens/home_screen/widgets/main_card.dart';
import 'package:flip/application/presentation/screens/message_screen/message_screen.dart';
import 'package:flip/application/presentation/widgets/flip_logo/flip_logo.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override 
  Widget build(BuildContext context) {
    super.build(context); 
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kWidth10,
                  const FlipLogoText(
                    logoSize: 35,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const MessageScreen()));
                      },
                      icon: const Icon(Iconsax.sms_notification)),
                ],
              ),
              StorySection(),
              const Divider(
                thickness: .1,
              ),
              HomeMainFeedsCard()
            ],
          ),
        ));
  }
}

class StorySection extends StatelessWidget {
  const StorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: index == 0
                          ? const AssetImage('assets/IMG_2468.JPG')
                          : const AssetImage(
                              'assets/brunette-girl-walking-through-park-during-autumn.jpg'),
                      radius: 35,
                    ),
                    index == 0
                        ? const Text('Faizy', style: TextStyle(fontSize: 12))
                        : const Text(
                            'Jasmy jain',
                            style: TextStyle(fontSize: 12),
                          )
                  ],
                ));
          }),
    );
  }
}



//  index == 0
                        // ? Container(
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(6),
                        //       color: const Color.fromARGB(20, 159, 159, 159),
                        //     ),
                        //     child: const Padding(
                        //       padding: EdgeInsets.all(12.0),
                        //       child: Text(
                        //         'All the dreams like twinkling stars,stars are like glowing gems...;',
                        //         style: TextStyle(fontSize: 18),
                        //       ),
                        //     ),
                        //   )
//                         : 